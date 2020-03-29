



import UIKit

class MyProfileVC: ParentViewController {
    
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet var titles: [UILabel]!
    @IBOutlet var titlesData: [UILabel]!
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var address: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "حسابي"
        
        menuBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        menuBtn.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        menuBtn.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        menuBtn.setImage(#imageLiteral(resourceName: "menu"), for: .normal)
        
        menuBtn.addTarget(self, action: #selector(self.openSideMenu), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: menuBtn)
        
        menuBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        menuBtn.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        menuBtn.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        menuBtn.setImage(#imageLiteral(resourceName: "edit"), for: .normal)
        
        menuBtn.addTarget(self, action: #selector(self.openEditProfile), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuBtn)
        
        applyDesign()
        
        userImage.sd_setImage(with: URL(string: User.shared().image ?? ""), placeholderImage: UIImage(named: "placeholder"))
        name.text = User.shared().display_name
        phone.text = User.shared().phone
        email.text = User.shared().email
        address.text = User.shared().address
        print(User.shared().access_token)
    }

    @objc func openEditProfile(_ sender: UIButton) {
        performSegue(withIdentifier: "toEditProfile", sender: nil)
    }
    
    func applyDesign(){
        imageContainer.backgroundColor = Color.theme.value
        userImage.layer.cornerRadius = 60
        userImage.clipsToBounds = true
        userImage.layer.borderColor = UIColor.white.cgColor
        userImage.layer.borderWidth = 3
        
        for title in titles {
            title.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().smallFontSize)
            title.textColor = Color.lightText.value
        }
        
        for title in titlesData {
            title.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
            title.textColor = Color.darkText.value
        }
    }
    
    //Side Menu
    @objc func openSideMenu(_ sender: UIButton) {
        performSegue(withIdentifier: "openMenu", sender: nil)
    }
}
