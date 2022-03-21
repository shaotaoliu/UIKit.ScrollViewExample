import UIKit

class SelectResultViewController: UITableViewController {

    var items: [Item]!

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableSelectionResultCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].description
        return cell
    }

}
