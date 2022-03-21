import UIKit

class ItemViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var item: Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = item.description
        label.text = item.description
    }
}
