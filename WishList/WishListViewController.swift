import UIKit

class WishListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var wishLists = [WishList]() {
        // didSet: 새로운 값이 저장된 직후에 호출됨.
        didSet {
            self.saveWishList()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.loadWishList()
    }
    
    @IBAction func tapBackButton(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapAddButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "버킷리스트 등록", message: nil, preferredStyle: .alert)
        let registerButton = UIAlertAction(title: "등록", style: .default, handler: { [weak self] _ in
            //textFields에 적힌 값을 가져와서 titls에 저장함.
            guard let title = alert.textFields?[0].text else { return }
            let wishList = WishList(title: title, done: false)
            // 이러면 wishLists 배열에 방금 작성한 내용이 추가됨
            self?.wishLists.append(wishList)
            self?.tableView.reloadData()
        })
        let cancleButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(cancleButton)
        alert.addAction(registerButton)
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "버킷리스트를 입력해 주세요"
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - 데이터 저장
    func saveWishList() {
        let data = self.wishLists.map {
            [
                "title": $0.title,
                "done": $0.done
            ]
        }
        let userDefaults = UserDefaults.standard
        // set을 통해 value로 data를, key 값으로 wishLists를 저장
        userDefaults.set(data, forKey: "wishLists")
    }
    
    // MARK: - 데이터 로드
    func loadWishList() {
        let userDefaults = UserDefaults.standard
        // object 메소드를 사용하여 키 값에 맞는 value값을 가져옴. 다만, Any타입이라 변환 필요
        guard let data = userDefaults.object(forKey: "wishLists") as? [[String: Any]] else { return }
        // 다시 wishLists에 변환된 data 저장
        self.wishLists = data.compactMap {
            guard let title = $0["title"] as? String else { return nil }
            guard let done = $0["done"] as? Bool else { return nil }
            return WishList(title: title, done: done)
        }
    }
}

extension WishListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.wishLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let wishList = self.wishLists[indexPath.row]
        cell.textLabel?.text = wishList.title
        if wishList.done == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
}

extension WishListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var wishList = self.wishLists[indexPath.row]
        // 버튼을 누를때마다 true가 저장되어있으면 false로, false가 저장되어있으면 true로 변경되도록
        wishList.done = !wishList.done
        self.wishLists[indexPath.row] = wishList
        // 선택된 cell만을 reload
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
