import UIKit

class PrefetchViewController: UITableViewController, UITableViewDataSourcePrefetching {

    let vm = PrefetchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.prefetchDataSource = self
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.total
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "loading..."
        
        vm.fetch(id: indexPath.row + 1) { id in
            cell.textLabel?.text = "Item \(id)"
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            print("Prefetching \(indexPath.row) ......")
            vm.fetch(id: indexPath.row, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            print("Cancelled \(indexPath.row)")
        }
    }
}

class PrefetchViewModel {
    
    let total = 100
    var set: Set<Int> = []
    
    init() {
        for i in 1...20 {
            set.insert(i)
        }
    }
    
    func fetch(id: Int, completion: ((Int) -> Void)?) {
        if set.contains(id) {
            completion?(id)
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.set.insert(id)
            completion?(id)
        })
    }
}
