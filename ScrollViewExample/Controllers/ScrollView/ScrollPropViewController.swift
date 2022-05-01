import UIKit

class ScrollPropViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var labelFrameHeight: UILabel!
    @IBOutlet weak var labelContentHeight: UILabel!
    @IBOutlet weak var labelOffsetY: UILabel!
    
    private var vm = ItemViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        loadData()
    }
    
    private func loadData() {
        vm.loadNextPage {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScrollViewPropCell", for: indexPath)
        cell.textLabel?.text = vm.items[indexPath.row].description
        return cell
    }

}

extension ScrollPropViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        labelFrameHeight.text = "\(Int(tableView.frame.height))"
        labelContentHeight.text = "\(Int(tableView.contentSize.height))"
        labelOffsetY.text = "\(Int(tableView.contentOffset.y))"
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        labelStatus.text = "Starting to scroll"
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        labelStatus.text = "End to scroll"
    }
    
}
