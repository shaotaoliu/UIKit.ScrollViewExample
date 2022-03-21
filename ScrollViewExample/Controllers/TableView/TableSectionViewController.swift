import UIKit

class TableSectionViewController: UITableViewController {
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewSectionCell", for: indexPath)
        cell.textLabel?.text = vm.movies[indexPath.section].names[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var content = UIListContentConfiguration.groupedHeader()
        content.text = vm.movies[section].category
        content.textProperties.color = .systemGreen

        switch section {
        case 0:
            content.image = UIImage(systemName: "graduationcap.circle")
        case 1:
            content.image = UIImage(systemName: "graduationcap.circle")
        default:
            content.image = UIImage(systemName: "ellipsis.circle")
        }
        
        let header = UITableViewHeaderFooterView()
        header.contentConfiguration = content
        return header
    }
    
}
