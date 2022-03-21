import UIKit

class ScrollDownViewController: UITableViewController {

    private var vm = ItemViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScrollDownTableViewCell", for: indexPath)
        cell.textLabel?.text = vm.items[indexPath.row].description
        return cell
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if reachedBottom(scrollView) {
            if vm.loadNextPage() > 0 {
                tableView.reloadData()
            }
        }
    }

    private func reachedBottom(_ scrollView: UIScrollView) -> Bool {
        // the height of the frame in the screen
        let frameHeight  = scrollView.frame.size.height
        
        // the distance from the top of the scroll view to current top of the screen
        let offset = scrollView.contentOffset.y
        
        // the height of the scroll view
        let contentHeight  = scrollView.contentSize.height
        
        return frameHeight + offset >= contentHeight
    }
}
