import UIKit

class Diffable2TableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    var dataSource: FruitDataSource!
    var index = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = FruitDataSource(tableView: tableView, cellProvider: { tableView, indexPath, fruit in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = fruit.title
            return cell
        })
        
        tableView.delegate = self
        dataSource.reload()
    }

    @IBAction func editTapped(_ sender: Any) {
        editButton.title = tableView.isEditing ? "Edit" : "Done"
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        dataSource.add(fruit: Fruit(title: "Fruit \(index)"))
        index += 1
    }
}

extension Diffable2TableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fruit = dataSource.itemIdentifier(for: indexPath)
        print(fruit?.title ?? "")
    }
}

class FruitDataSource: UITableViewDiffableDataSource<Section, Fruit> {
    
    var fruits: [Fruit] = [
        Fruit(title: "Apple"),
        Fruit(title: "Grape"),
        Fruit(title: "Orange")
    ]
    
    func reload() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Fruit>()
        snapshot.appendSections([.first])
        snapshot.appendItems(fruits)
        apply(snapshot, animatingDifferences: true)
    }
    
    func add(fruit: Fruit) {
        fruits.append(fruit)
        
        var snapshot = snapshot()
        snapshot.appendItems([fruit])
        apply(snapshot, animatingDifferences: true)
    }
    
    func delete(fruit: Fruit) {
        if let index = fruits.firstIndex(where: { $0.title == fruit.title }) {
            fruits.remove(at: index)
            
            var snapshot = snapshot()
            snapshot.deleteItems([fruit])
            apply(snapshot, animatingDifferences: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let fruit = self.itemIdentifier(for: indexPath) {
                delete(fruit: fruit)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if sourceIndexPath == destinationIndexPath {
            return
        }
        
        let fruit = fruits[sourceIndexPath.row]
        fruits.remove(at: sourceIndexPath.row)
        fruits.insert(fruit, at: destinationIndexPath.row)
        
        var snapshot = snapshot()
        
        if destinationIndexPath.row == 0 {
            snapshot.moveItem(fruit, beforeItem: fruits[1])
        }
        else {
            snapshot.moveItem(fruit, afterItem: fruits[destinationIndexPath.row - 1])
        }
        
        apply(snapshot, animatingDifferences: true)
    }
}
