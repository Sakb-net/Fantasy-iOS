



import UIKit

class EditProfileVC: ParentViewController {
    var presenter = ProfilePresenter()
    
    @IBOutlet weak var userImages: UIImageView!
    @IBOutlet var textFiledContainer: [UIView]!
    @IBOutlet var textFileds: [UITextField]!
    @IBOutlet weak var saveChanges: UIButton!
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var distirct: UITextField!
    
    
    @IBAction func EditProfileAction(_ sender: Any) {
        let name = self.name.text
        let phone = self.phone.text
        let email = self.email.text
        let city = self.city.text
        let state = self.distirct.text
        presenter.updateProfile(updatedParameters: [name!,phone!,email!,city!,state!], onSuccess: { (successMessage) in
            self.showAlert(title: "", message: successMessage ?? "", shouldpop: false)
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "تعديل بياناتي"
        applyDesign()
        
        userImage.sd_setImage(with: URL(string: User.shared().image ?? ""), placeholderImage: UIImage(named: "placeholder"))
        name.text = User.shared().display_name
        phone.text = User.shared().phone
        email.text = User.shared().email
        city.text = User.shared().city
        distirct.text = User.shared().state
    }

    func applyDesign(){
        
        userImages.layer.cornerRadius = 60
        userImages.clipsToBounds = true
        
        for filed in textFiledContainer {
            filed.layer.cornerRadius = 10
            filed.layer.borderWidth = 1
            filed.layer.borderColor = Color.border.value.cgColor
        }
        
        for filed in textFileds {
            filed.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
            filed.textColor = Color.darkText.value
        }
        
        
        saveChanges.backgroundColor = Color.theme.value
        saveChanges.layer.cornerRadius = 10
        saveChanges.titleLabel?.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        saveChanges.setTitleColor(UIColor.white, for: .normal)
        
    }
    
}
