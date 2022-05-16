import UIKit

class TableIndexViewController: UITableViewController {

    let vm = IndexViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return vm.groupedCities.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.groupedCities[vm.initials[section]]?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let initial = vm.initials[indexPath.section]
        cell.textLabel?.text = vm.groupedCities[initial]![indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(vm.initials[section])
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return vm.initials.map { String($0) }
        
        // dispaly A-Z as the indexes:
        // return vm.indexes.map { String($0) }
    }
    
    // Determine where to go if the selected index is not in the list
    // override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
    //     return vm.initials.firstIndex(of: title.first!) ?? 0
    // }
}

class IndexViewModel {
    
    let cities = [
        "Amarillo", "Atlanta", "Albany", "Austin",
        "Boston", "Boulder", "Baltimore",
        "Columbia", "Charlotte", "Cincinnati", "Chicago",
        "Denver", "Dallas", "Detroit",
        "Houston", "Hamilton",
        "Los Angeles", "Las Vegas", "Long Beach",
        "Miami", "Memphis", "Minneapolis",
        "New York", "New Orleans", "Newport Beach",
        "Portland", "Phoenix", "Pittsburgh", "Pasadena",
        "Riverside", "Rockford", "Richmond",
        "Seattle", "San Jose", "San Francisco", "San Diego", "Santa Fe", "Sacramento", "Santa Barbara",
        "Torrance", "Tucson", "Temple City",
        "Washington", "Wilmington"
    ]
    
    var initials: [Character] {
        var set = Set<Character>()
        cities.forEach {
            set.insert($0.first!)
        }
        return set.map {
            $0
        }.sorted()
    }
    
    var indexes: [Character] {
        return Array("abcdefghijklmnopqrstuvwxyz".uppercased())
    }
    
    var groupedCities: [Character: [String]] {
        Dictionary(grouping: cities.sorted(), by: { $0.first! })
    }
}
