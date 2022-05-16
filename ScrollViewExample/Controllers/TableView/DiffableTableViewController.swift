import UIKit

class DiffableTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var dataSource: UITableViewDiffableDataSource<Section, Fruit>!
    
    var fruits = ["Apple", "Grape", "Peach", "Orange", "Cherry", "Blueberry", "Watermelon"].map {
        Fruit(title: $0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, fruit in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = fruit.title
            return cell
        })
        
        updateDataSource()
        tableView.delegate = self
    }

    func updateDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Fruit>()
        snapshot.appendSections([.first])
        snapshot.appendItems(fruits)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension DiffableTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let fruit = dataSource.itemIdentifier(for: indexPath) else {
            return
        }

        showFruit(fruit: fruit)
    }
    
    private func showFruit(fruit: Fruit) {
        let alert = UIAlertController(title: fruit.title, message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
}

enum Section {
    case first
}

struct Fruit: Hashable {
    let title: String
}
