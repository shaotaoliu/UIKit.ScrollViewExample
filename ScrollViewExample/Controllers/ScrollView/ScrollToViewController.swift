import UIKit

class ScrollToViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonGoTop: UIButton!
    @IBOutlet weak var buttonBottom: UIButton!
    @IBOutlet weak var buttonGoRow: UIButton!
    @IBOutlet weak var buttonEdit: UIBarButtonItem!
    @IBOutlet weak var textFieldRow: UITextField!
    
    private var vm = ItemViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        loadData()
    }
    
    private func loadData() {
        vm.loadNextPage {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // to make it work, use a non-system bar button item
    @IBAction func buttonEditTapped(_ sender: Any) {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            buttonEdit.title = "Edit"
        }
        else {
            tableView.setEditing(true, animated: true)
            buttonEdit.title = "Done"
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            vm.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func buttonGoTopTapped(_ sender: Any) {
//        let offset = CGPoint(x: 0, y: 0)
//        tableView.setContentOffset(offset, animated: true)
        
//        tableView.contentOffset.y = 0
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    @IBAction func buttonGoBottomTapped(_ sender: Any) {
//        let offset = CGPoint(x: 0, y: tableView.contentSize.height - tableView.frame.height)
//        tableView.setContentOffset(offset, animated: true)
        
//        tableView.contentOffset.y = tableView.contentSize.height - tableView.frame.height
        
        let indexPath = IndexPath(row: vm.items.count - 1, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    @IBAction func buttonGoRowTapped(_ sender: Any) {
        if let text = textFieldRow.text, let row = Int(text) {
            let indexPath = IndexPath(row: row - 1, section: 0)
            tableView.scrollToRow(at: indexPath, at: .none, animated: true)
        }
    }
    
}

extension ScrollToViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScrollToTableViewCell", for: indexPath)
        cell.textLabel?.text = vm.items[indexPath.row].description
        return cell
    }
    
}
