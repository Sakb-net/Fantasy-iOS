




import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn
import Google
import TwitterKit
import SkyFloatingLabelTextField

class SignUpVC: ParentViewController, GIDSignInUIDelegate, GIDSignInDelegate, SelectedDropDownType {
    var userInfo : signUpUser!
    func selectedType(selectedType: DropDownTypes, selectedItem: Any) {
        if selectedType == .City {
            let selectedCity = selectedItem as! City
            self.cityTF.text = selectedCity.name
        }
    }
    
    var loginPresenter = LoginPresenter()

    @IBOutlet weak var nameTF: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTF: SkyFloatingLabelTextField!
    @IBOutlet weak var passTF: SkyFloatingLabelTextField!
    @IBOutlet weak var confirmPassTF: SkyFloatingLabelTextField!
    @IBOutlet weak var phoneTF: SkyFloatingLabelTextField!
    @IBOutlet weak var cityTF: SkyFloatingLabelTextField!
    @IBOutlet weak var stateTF: SkyFloatingLabelTextField!
    @IBOutlet weak var signUpBT: UIButton!
    
    @IBAction func facebookLoginAction(_ sender: Any) {
        loginPresenter.facebookLogin(vc: self)
    }
    @IBAction func twitterLoginAction(_ sender: Any) {
        loginPresenter.twitterLogin()
    }
    @IBAction func gmailLoginAction(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    @IBAction func loginAction(_ sender: Any) {
    }
    @IBAction func createAccountAction(_ sender: Any) {
        if isNetworkReachable {
            createAccountAction()
        }else{
            self.showAlert(title: "أنت غير متصل الإنترنت", message: "", shouldpop: false)
        }
    }
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameTF.delegate = self
        self.emailTF.delegate = self
        self.passTF.delegate = self
        self.confirmPassTF.delegate = self
        self.phoneTF.delegate = self
        self.cityTF.delegate = self
        self.stateTF.delegate = self
        
        loginPresenter.loginBTCongig(loginBT: self.signUpBT)
        addLeftViewToPassTF()
        if "lang".localized == "ar" {
            self.nameTF.textAlignment = .right
            self.emailTF.textAlignment = .right
            self.passTF.textAlignment = .right
            self.confirmPassTF.textAlignment = .right
            self.phoneTF.textAlignment = .right
            self.cityTF.textAlignment = .right
            self.stateTF.textAlignment = .right
        
            self.nameTF.titleLabel.textAlignment = .right
            self.emailTF.titleLabel.textAlignment = .right
            self.passTF.titleLabel.textAlignment = .right
            self.confirmPassTF.titleLabel.textAlignment = .right
        
            self.phoneTF.titleLabel.textAlignment = .right
            self.cityTF.titleLabel.textAlignment = .right
            self.stateTF.titleLabel.textAlignment = .right
        }else {
            self.nameTF.textAlignment = .left
                self.emailTF.textAlignment = .left
                self.passTF.textAlignment = .left
                self.confirmPassTF.textAlignment = .left
                self.phoneTF.textAlignment = .left
                self.cityTF.textAlignment = .left
                self.stateTF.textAlignment = .left
            
                self.nameTF.titleLabel.textAlignment = .left
                self.emailTF.titleLabel.textAlignment = .left
                self.passTF.titleLabel.textAlignment = .left
                self.confirmPassTF.titleLabel.textAlignment = .left
            
                self.phoneTF.titleLabel.textAlignment = .left
                self.cityTF.titleLabel.textAlignment = .left
                self.stateTF.titleLabel.textAlignment = .left
        }
        self.cityTF.addTarget(self, action: #selector(openDropDown), for: .touchDown)

        facebookButtonConfig()
        googleButtonConfig()
    }
    
    func createAccountAction() {
        
        guard let displayName = self.nameTF.text, displayName != "" else {
            self.showAlert(title: "", message: "الرجاء إدخال اسم المستخدم", shouldpop: false)
            return
        }
        
        guard let phone = self.phoneTF.text, phone != "" else {
            self.showAlert(title: "", message: "الرجاء إدخال رقم التليفون", shouldpop: false)
            return
        }
        
        guard let emailAddress = self.emailTF.text, emailAddress != "" else {
            self.showAlert(title: "", message: "الرجاء إدخال اسم المستخدم او البريد الالكتروني", shouldpop: false)
            return
        }
        
        guard let city = self.cityTF.text, city != "" else {
            self.showAlert(title: "", message: "الرجاء إختيار المدينة", shouldpop: false)
            return
        }
        
        guard let district = self.stateTF.text, district != "" else {
            self.showAlert(title: "", message: "الرجاء إدخال الحي الذي تسكنه", shouldpop: false)
            return
        }
        
        guard let pass = self.passTF.text, pass != "" else {
            self.showAlert(title: "", message: "الرجاء إدخال كلمة المرور", shouldpop: false)
            return
        }
        
        guard let confirmPass = self.confirmPassTF.text, confirmPass != "" else {
            self.showAlert(title: "", message: "الرجاء إدخال تأكيد كلمة المرور", shouldpop: false)
            return
        }
        
        if pass != confirmPass {
            self.showAlert(title: "", message: "كلمة المرور غير متطابقة", shouldpop: false)
            return
        }
        
        userInfo = signUpUser(email: emailAddress, password: pass, displayName: displayName, phone: phone, city: city, reg_site: district)
        let termsVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "TermsVC") as! TermsVC
        termsVC.user = userInfo
        termsVC.delegate = self
        self.present(termsVC, animated: true, completion: nil)

    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if user != nil {
            print(user.profile.email)
            
        }
    }
    func facebookButtonConfig(){
        if (AccessToken.current != nil) {
            // User is logged in, do work such as go to next view controller.
        }
    }
    
    func googleButtonConfig(){
        GIDSignIn.sharedInstance()?.uiDelegate = self
        GIDSignIn.sharedInstance()?.delegate = self
    }
    
    func addLeftViewToPassTF(){
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "show_pass"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(self.passTF.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.showPass), for: .touchUpInside)
        let button2 = UIButton(type: .custom)
        button2.setImage(UIImage(named: "show_pass"), for: .normal)
        button2.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button2.frame = CGRect(x: CGFloat(self.passTF.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button2.addTarget(self, action: #selector(self.showConfirmPass), for: .touchUpInside)
        if "lang".localized == "ar"{
//            self.passTF.leftView = button
//            self.passTF.leftViewMode = .always
//            self.confirmPassTF.leftView = button2
//            self.confirmPassTF.leftViewMode = .always
        }else {
            self.passTF.rightView = button
            self.passTF.rightViewMode = .always
            self.confirmPassTF.rightView = button2
            self.confirmPassTF.rightViewMode = .always
        }
    }
    @objc func showPass(_ sender: Any) {
        if self.passTF.text != "" {
        if self.passTF.isSecureTextEntry {
            self.passTF.isSecureTextEntry = false
        }else {
            self.passTF.isSecureTextEntry = true
        }
        }
    }
    @objc func showConfirmPass(_ sender: Any) {
        if self.confirmPassTF.text != "" {
        if self.confirmPassTF.isSecureTextEntry {
            self.confirmPassTF.isSecureTextEntry = false
        }else {
            self.confirmPassTF.isSecureTextEntry = true
        }
    }
    }
    @objc func openDropDown(_ sender: Any) {
        let dropDownVC = Storyboard().dropDownStoryboard.instantiateViewController(withIdentifier: "DropDownVC") as! DropDownVC
        
        dropDownVC.selectDelegate = self
        dropDownVC.selectedType = .City
        
        present(dropDownVC, animated: true
            , completion: nil)
    }
}
extension SignUpVC : SignUpDelegate {
    
    func acceptTerms(isAccepted: Bool) {
        if isAccepted {
            let favTeamVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "FavTeamVC") as! FavTeamVC
            favTeamVC.user = userInfo
            favTeamVC.isFavTeam = true
            favTeamVC.delegate = self
            self.present(favTeamVC, animated: true, completion: nil)
        }
    }
    
    func chooseFavTeam(link: String) {
        createUser(link: link)
    }
    func createUser(link: String){
        self.showLoader()
        LoginPresenter().userRegister(email: userInfo.email, password: userInfo.password, displayName: userInfo.displayName, phone: userInfo.phone, city: userInfo.city, reg_site: userInfo.reg_site, favTeam: link, onSuccess: { (userInfo) in
            self.hideLoader()
            UserDefaults.standard.set(self.userInfo.password, forKey: "UserPass")
            let favTeamVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "FavTeamVC") as! FavTeamVC
            favTeamVC.favTeamLink = link
            favTeamVC.isFavTeam = false
            favTeamVC.delegate = self
            self.navigationController?.pushViewController(favTeamVC, animated: true)
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
}
struct signUpUser{
    var email : String
    var password : String
    var displayName : String
    var phone : String
    var city : String
    var reg_site : String
    
}
protocol SignUpDelegate {
    func acceptTerms(isAccepted : Bool)
    func chooseFavTeam(link : String)
}
