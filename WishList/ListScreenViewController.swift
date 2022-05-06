import UIKit
import DropDown

class ViewController: UIViewController {

    @IBOutlet weak var dropView: UIView!
    @IBOutlet weak var tfInput: UITextField!
    @IBOutlet weak var ivIcon: UIImageView!
    @IBOutlet weak var btnSelect: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        setDropDown()
    }

    let dropDown = DropDown()
    let itemList = ["목록", "기록", "설정"]
    
    func initUI() {
        dropView.backgroundColor = UIColor.init(named: "#F1F1F1")
        dropView.layer.cornerRadius = 10
        
        DropDown.appearance().textColor = UIColor.black
        DropDown.appearance().selectedTextColor = UIColor.blue
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().selectionBackgroundColor = UIColor.lightGray
        DropDown.appearance().setupCornerRadius(10)
        dropDown.dismissMode = .automatic
        
        tfInput.text = "목록"
        
        ivIcon.tintColor = UIColor.gray
    }
    
    // DropDown
    func setDropDown() {
        dropDown.dataSource = itemList
        
        // anchorView를 통해 UI와 연결 (anchorView를 통해서 dropdown 버튼에 붙임)
        dropDown.anchorView = self.dropDown
        
        // dropDown 위치 변경
        dropDown.bottomOffset = CGPoint(x: 15, y: 88)
        dropDown.width = 44 // 글꼴이나 크기 변경하고 width 값을 늘린 후, 중앙정렬 필요. (중앙정렬 어떻게하냐..)
        

            
        // selectionAction을 통해 아이템의 index와 item(이름)을 가져올 수 있다.
        dropDown.selectionAction = { [weak self] (index, item) in
            self?.tfInput.text = item
            self?.ivIcon.image = UIImage.init(named: "16")
            // 다시 메뉴를 열 때, 이전에 선택한 값이 선택되지 않은 상태로 열림.
            self?.dropDown.clearSelection()
        }
        
        // 취소 시 처리
        dropDown.cancelAction = { [weak self] in
            // 빈 화면 터치 시 DropDown이 사라지고, 아이콘을 원래대로 변경
            self?.ivIcon.image = UIImage.init(named: "16")
        }
    }

    @IBAction func tapDropDownButton(_ sender: Any) {
        // dropDown 팝업을 보여줌
        dropDown.show()
        // 아이콘 이미지를 변경하여 DropDown이 펼쳐진 것을 보여줌
        self.ivIcon.image = UIImage.init(named: "AppIcon-2")
    }

}

