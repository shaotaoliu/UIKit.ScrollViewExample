import UIKit

class Diffable3TableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var dataSource: FruitSectionDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = FruitSectionDataSource(tableView: tableView, cellProvider: { tableView, indexPath, fruit in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = fruit.title
            return cell
        })
        
        dataSource.reload()
    }
}

class FruitSectionDataSource: UITableViewDiffableDataSource<FruitSection, Fruit> {
    
    var fruits = ["Apple", "Grape", "Peach", "Orange", "Cherry", "Blueberry", "Watermelon"].map {
        Fruit(title: $0)
    }
    
    func reload() {
        var snapshot = NSDiffableDataSourceSnapshot<FruitSection, Fruit>()
        snapshot.appendSections(FruitSection.allCases)
        snapshot.appendItems(Array(fruits[0...3]), toSection: .first)
        snapshot.appendItems(Array(fruits[4...6]), toSection: .second)
        apply(snapshot, animatingDifferences: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return FruitSection.first.rawValue.uppercased()
        default:
            return FruitSection.second.rawValue.uppercased()
        }
    }
}

enum FruitSection: String, CaseIterable {
    case first
    case second
}
