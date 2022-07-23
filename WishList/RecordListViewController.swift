import UIKit
import DropDown

class RecordListViewController: UIViewController {
    
    @IBOutlet weak var dropView: UIView!
    @IBOutlet weak var ivIcon: UIImageView!
    @IBOutlet weak var tfInput: UITextField!
    @IBOutlet weak var btnSelect: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        initUI()
        setDropDown()
        self.navigationItem.rightBarButtonItem?.tintColor = .black
        self.ivIcon.image = UIImage.init(named: "free-icon-font-angle-small-up-3916911")
    }
    
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
        tfInput.text = "기록"
        ivIcon.tintColor = UIColor.gray
    }
    
    func setDropDown() {
        dropDown.dataSource = viewListLabel
        
        // anchorView를 통해 UI와 연결 (anchorView를 통해서 dropdown 버튼에 붙임)
        dropDown.anchorView = self.dropDown
        
        // dropDown 위치 변경
        dropDown.bottomOffset = CGPoint(x: 15, y: 88)
        dropDown.width = 44 // 글꼴이나 크기 변경하고 width 값을 늘린 후, 중앙정렬 필요. (중앙정렬 어떻게하냐..)
        dropDown.textFont = UIFont(name: "SDMiSaeng", size: CGFloat(20))!
            
        // selectionAction을 통해 아이템의 index와 item(이름)을 가져올 수 있다.
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.tfInput.text = item
            // 드롭박스를 통한 화면 전환
            if self?.tfInput.text == "목록" {
                guard let WishListCategoryViewContoller = self?.storyboard?.instantiateViewController(withIdentifier: "WishListCategoryViewContoller") else { return }
                self?.navigationController?.pushViewController(WishListCategoryViewContoller, animated: true)
            }
            
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
    
    @IBAction func tapDropDownButton(_ sender: UIButton) {
        // dropDown 팝업을 보여줌
        dropDown.show()
        // DropDown이 펼쳐져있을 경우의 이미지!
        self.ivIcon.image = UIImage.init(named: "free-icon-font-angle-small-down-3916919")
    }
    
    @IBAction func tapSettingsButton(_ sender: UIBarButtonItem) {
        guard let SettingsViewController = self.storyboard?.instantiateViewController(withIdentifier: "SettingsScreenViewController") else { return }
        self.navigationController?.pushViewController(SettingsViewController, animated: true)
    }
}
