import UIKit

class ScrollUpViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    private var vm = ItemViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl = refreshControl
        
        refreshControl.beginRefreshing()
        loadData()
    }
    
    @objc func refresh() {
        if vm.loading || vm.items.count >= 100 {
            tableView.refreshControl?.endRefreshing()
            return
        }
        
        loadData()
    }
    
    private func loadData() {
        vm.loadNextPage {
            DispatchQueue.main.async {
                self.tableView.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        let bottomRow = IndexPath(row: vm.items.count - 1, section: 0)
//        tableView.scrollToRow(at: bottomRow, at: .none, animated: false)
//    }
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.contentOffset.y < -10 {
//            vm.loadNextPage() {
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//
//                    let indexPath = IndexPath(row: self.vm.items.count - 1, section: 0)
//                    self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
//                }
//            }
//        }
//    }
}

extension ScrollUpViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScrollUpTableViewCell", for: indexPath)
        cell.textLabel?.text = vm.items[vm.items.count - indexPath.row - 1].description
        return cell
    }
}
