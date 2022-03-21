import UIKit

class ScrollUpViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    private var vm = ItemViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let bottomRow = IndexPath(row: vm.items.count - 1, section: 0)
        tableView.scrollToRow(at: bottomRow, at: .none, animated: false)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < -10 {
            let count = vm.loadNextPage()
            if count > 0 {
                tableView.reloadData()
                
                let indexPath = IndexPath(row: count - 1, section: 0)
                tableView.scrollToRow(at: indexPath, at: .top, animated: false)
            }
        }
    }
}

extension ScrollUpViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScrollUpTableViewCell", for: indexPath)
        cell.textLabel?.text = vm.items[vm.items.count - indexPath.row - 1].description
        return cell
    }
}
