import UIKit

class TableColorViewController: UITableViewController {

    private var vm = MovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return vm.movies.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.movies[section].names.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewColorCell", for: indexPath)
        cell.textLabel?.text = vm.movies[indexPath.section].names[indexPath.row]
        cell.textLabel?.textColor = .systemRed
        
        let bgView = UIView()
        bgView.backgroundColor = .systemOrange
        cell.selectedBackgroundView = bgView
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return vm.movies[section].category
//    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var content = UIListContentConfiguration.groupedHeader()
        content.text = vm.movies[section].category
        content.textProperties.alignment = .natural
        content.textProperties.color = .white

        let header = UITableViewHeaderFooterView()
        header.contentConfiguration = content
        
        let view = UIView()
        view.backgroundColor = .systemGreen
        
        header.backgroundView = view
        return header
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        var content = UIListContentConfiguration.groupedHeader()
        content.text = "Total: \(vm.movies[section].names.count)"
        
        let footer = UITableViewHeaderFooterView()
        footer.contentConfiguration = content
        return footer
    }

}
