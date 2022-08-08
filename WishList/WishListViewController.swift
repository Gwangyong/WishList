import UIKit

class WishListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var task: Task?
    var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    

    @IBAction func tapBackButton(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapAddButton(_ sender: UIButton) {
    }
}
