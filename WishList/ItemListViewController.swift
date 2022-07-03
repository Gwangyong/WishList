import UIKit
import DropDown

class ItemListViewController: UIViewController {

    // tfInput(TextFieldInput) / ivIcon(ImageViewIcon)
    @IBOutlet weak var dropView: UIView!
    @IBOutlet weak var tfInput: UITextField!
    @IBOutlet weak var ivIcon: UIImageView!
    @IBOutlet weak var btnSelect: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        setDropDown()
        self.navigationItem.rightBarButtonItem?.tintColor = .black
        self.ivIcon.image = UIImage.init(named: "free-icon-font-angle-small-up-3916911")
    }
    
    let kategorieList = ["전체", "여행", "가족", "친구", "연인", "배움", "도전", "ETC"]
    let dropDown = DropDown()
    let viewListLabel = ["목록", "기록"]
    
    func initUI() {
        dropView.backgroundColor = UIColor.init(named: "#F1F1F1")
        dropView.layer.cornerRadius = 10
        DropDown.appearance().textColor = UIColor.black
        DropDown.appearance().selectedTextColor = UIColor.blue
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().selectionBackgroundColor = UIColor.lightGray
        DropDown.appearance().setupCornerRadius(10)
        dropDown.dismissMode = .onTap
        tfInput.text = "목록"
        ivIcon.tintColor = UIColor.gray
    }
    
    // DropDown
    func setDropDown() {
        dropDown.dataSource = viewListLabel
        
        // anchorView를 통해 UI와 연결 (anchorView를 통해서 dropdown 버튼에 붙임)
        dropDown.anchorView = self.dropDown
        
        // dropDown 위치 변경
        dropDown.bottomOffset = CGPoint(x: 15, y: 88)
        dropDown.width = 44 // 글꼴이나 크기 변경하고 width 값을 늘린 후, 중앙정렬 필요. (중앙정렬 어떻게하냐..)
        dropDown.textFont = UIFont(name: "SDMiSaeng", size: CGFloat(20))!
            
        // selectionAction을 통해 아이템의 index와 item(이름)을 가져올 수 있다.
        dropDown.selectionAction = { [weak self] (index, item) in
            self?.tfInput.text = item
            //위의 대로, selectionAction이 발생하면 변경될 이미지.
            self?.ivIcon.image = UIImage.init(named: "free-icon-font-angle-small-up-3916911")
            // 다시 메뉴를 열 때, 이전에 선택한 값이 선택되지 않은 상태로 열림.
            self?.dropDown.clearSelection()
        }
        
        // 취소 시 처리
        dropDown.cancelAction = { [weak self] in
            // 빈 화면 터치 시 DropDown이 사라지고, 아이콘을 원래대로 변경
            self?.ivIcon.image = UIImage.init(named: "free-icon-font-angle-small-up-3916911")
        }
    }

    // btnSelect와 연결되어있음
    @IBAction func tapDropDownButton(_ sender: UIBarButtonItem) {
        // dropDown 팝업을 보여줌
        dropDown.show()
        // DropDown이 펼쳐져있을 경우의 이미지!
        self.ivIcon.image = UIImage.init(named: "free-icon-font-angle-small-down-3916919")
        
    }
    
}

// UITableView
extension ItemListViewController: UITableViewDataSource, UITableViewDelegate {
    
    // UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kategorieList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell else { return UITableViewCell() }
        // 위에 정의해준 itemNameList 배열의 indexPath.row 값으로 하여, 동일한 이름의 이미지와 이름을 가져다가 배치함
        let img = UIImage(named: "\(kategorieList[indexPath.row]).png")
        cell.itemIconView.image = img
        cell.itemNameLabel.text = kategorieList[indexPath.row]
        return cell
    }
    
    // UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("--> \(indexPath.row)")
    }
}

class ListCell: UITableViewCell {
    @IBOutlet weak var itemIconView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
}
