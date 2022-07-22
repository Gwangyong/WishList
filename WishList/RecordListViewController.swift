import UIKit
import DropDown

class RecordListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func tapSettingsButton(_ sender: UIBarButtonItem) {
        guard let SettingsViewController = self.storyboard?.instantiateViewController(withIdentifier: "SettingsScreenViewController") else { return }
        self.navigationController?.pushViewController(SettingsViewController, animated: true)
    }
}
