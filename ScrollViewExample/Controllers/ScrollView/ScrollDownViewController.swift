import UIKit

class ScrollDownViewController: UITableViewController {

    private var vm = ItemViewModel()
    private var offsetOfTableView: CGFloat?
    
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
            
            if !vm.loading && vm.items.count < 100 {
                tableView.tableFooterView = createSpinnerFooter()
                
                vm.loadNextPage() {
                    DispatchQueue.main.async {
                        self.tableView.tableFooterView = nil
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    private func createSpinnerFooter() -> UIView {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))
        let spinner = UIActivityIndicatorView()
        spinner.center = footer.center
        footer.addSubview(spinner)
        spinner.startAnimating()
        return footer
    }

    private func reachedBottom(_ scrollView: UIScrollView) -> Bool {
        
        if offsetOfTableView == nil {
            offsetOfTableView = scrollView.contentOffset.y
        }
        
        // the height of the frame in the screen
        let frameHeight  = scrollView.frame.size.height
        
        // the distance from the top of the scroll view to current top of the screen
        let offset = scrollView.contentOffset.y - offsetOfTableView!
        
        // the height of the scroll view
        let contentHeight  = scrollView.contentSize.height
        
        return frameHeight + offset >= contentHeight + 20
    }
}
