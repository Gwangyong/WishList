import UIKit

class SettingsScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem?.tintColor = .black
    }

    @IBAction func tapBackButton(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}
