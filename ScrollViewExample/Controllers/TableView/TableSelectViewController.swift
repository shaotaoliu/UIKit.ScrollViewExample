import UIKit

class TableSelectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    private var vm = ItemViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func showResults(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "TableSelectionResultViewController") as! SelectResultViewController
        
        if let indexPaths = tableView.indexPathsForSelectedRows {
            controller.items = []
            for indexPath in indexPaths {
                controller.items.append(vm.items[indexPath.row])
                tableView.deselectRow(at: indexPath, animated: false)
            }
            
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
}

extension TableSelectViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableSelectionCell", for: indexPath)
        cell.textLabel?.text = vm.items[indexPath.row].description
        return cell
    }
    
}
