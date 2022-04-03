import UIKit

class TableRowViewController: UITableViewController {

    let example = Example(name: "Kevin", title: "Manager", done: true, waiting: false)

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        switch indexPath.row {
        case 0:
            cell.backgroundColor = .systemRed
            cell.textLabel?.textColor = .white
            cell.textLabel?.text = "Name"
            
            let field = UITextField(frame: CGRect(x: 0, y: 0, width: 150, height: 31))
            field.text = example.name
            field.backgroundColor = .white
            field.layer.cornerRadius = 5
            cell.accessoryView = field
            
        case 1:
            cell.backgroundColor = .systemBlue
            cell.textLabel?.textColor = .white
            cell.textLabel?.text = "Title"
            
            let field = UITextField(frame: CGRect(x: 0, y: 0, width: 150, height: 31))
            field.text = example.title
            field.backgroundColor = .white
            field.layer.cornerRadius = 5
            cell.accessoryView = field
            
        case 2:
            cell.backgroundColor = .systemYellow
            cell.textLabel?.text = "Done"
            
            let sw = UISwitch()
            sw.isOn = example.done
            cell.accessoryView = sw
            
        default:
            cell.backgroundColor = .systemOrange
            cell.textLabel?.text = "Waiting"
            
            let sw = UISwitch()
            sw.isOn = example.waiting
            cell.accessoryView = sw
        }

        return cell
    }

}

struct Example {
    var name: String
    var title: String
    var done: Bool
    var waiting: Bool
}
