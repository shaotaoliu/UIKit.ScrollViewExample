import UIKit

class TableOperViewController: UITableViewController {

    private var vm = ItemViewModel(10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    // delete a row:
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            vm.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            vm.print()
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // add a row:
    @IBAction func addButtonTapped(_ sender: Any) {
        vm.addRow()
        
        let indexPath = IndexPath(row: vm.items.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // move a row:
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let item = vm.items[fromIndexPath.row]
        vm.items.remove(at: fromIndexPath.row)
        vm.items.insert(item, at: to.row)
    }
    
    // select a row:
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "ItemViewController") as! ItemViewController
        controller.item = vm.items[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension TableOperViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableOperationsCell", for: indexPath)
        cell.textLabel?.text = vm.items[indexPath.row].description
        return cell
    }
    
}
