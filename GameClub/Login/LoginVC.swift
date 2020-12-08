




import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn
import Google
import TwitterKit
import SkyFloatingLabelTextField

class LoginVC: ParentViewController, GIDSignInUIDelegate, GIDSignInDelegate{
    
    var loginPresenter = LoginPresenter()
    var isRememberMe:Bool = true

    @IBOutlet weak var backBT: UIButton!
    @IBOutlet weak var emailTF: SkyFloatingLabelTextField!
    @IBOutlet weak var passTF: SkyFloatingLabelTextField!
    @IBOutlet weak var loginBT: UIButton!
    @IBOutlet weak var FacebookLoginBT: UIButton!
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func forgetPasswordAction(_ sender: Any) {
        guard let url = URL(string: "http://sakbfantasy.sakb-co.com.sa/password/reset") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func LoginAction(_ sender: Any) {
        if isNetworkReachable{
            userLogin()
        }else{
            self.showAlert(title: "", message: "Internet is not available", shouldpop: true)
        }
    }
    
    @IBAction func createNewAccount(_ sender: Any) {
        performSegue(withIdentifier: "toRegister", sender: nil)
    }
    @IBAction func FacebookLogin(_ sender: Any) {
        loginPresenter.facebookLogin(vc: self)
    }
    @IBAction func GoogleSignIn(_ sender: Any) {
         GIDSignIn.sharedInstance().signIn()

    }
    @IBAction func TwitterLogin(_ sender: Any) {
       loginPresenter.twitterLogin()
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if user != nil {
        print(user.profile.email)
        }
//        GIDSignIn.sharedInstance().signOut()  //SignOut from GOOGLE
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Did logout via LoginButton")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.removeViewController(PitchVC.self)
        navigationController!.removeViewController(MyTeamVC.self)
        navigationController!.removeViewController(MyPointsVC.self)
        emailTF.delegate = self
        passTF.delegate = self


        self.navigationController?.navigationBar.isHidden = true
        loginBTCongig()
        addLeftViewToPassTF()
        if "lang".localized == "ar" {
            self.passTF.textAlignment = .right
            self.emailTF.textAlignment = .right
            self.emailTF.titleLabel.textAlignment = .right
            self.passTF.titleLabel.textAlignment = .right
        }else {
            self.passTF.textAlignment = .left
            self.emailTF.textAlignment = .left
            self.emailTF.titleLabel.textAlignment = .left
            self.passTF.titleLabel.textAlignment = .left
        }
        facebookButtonConfig()
        googleButtonConfig()
        
        if let _ =  UserDefaults.standard.value(forKey: "isRememberMe") as? Bool {
            self.emailTF.text = UserDefaults.standard.value(forKey: "email") as? String
            self.passTF.text = UserDefaults.standard.value(forKey: "password") as? String
        }
    }
    
    func userLogin(){
        guard let emailAddress = self.emailTF.text, emailAddress != "" else {
            self.showAlert(title: "", message: "الرجاء إدخال اسم المستخدم او البريد الالكتروني", shouldpop: false)
            return
        }
        
        guard let pass = self.passTF.text, pass != "" else {
            self.showAlert(title: "", message: "الرجاء إدخال كلمة المرور", shouldpop: false)
            return
        }
        
        self.showLoader()
        loginPresenter.userLogin(email: emailAddress, password: pass, onSuccess: { (userInfo) in
            self.hideLoader()
            UserDefaults.standard.set(pass, forKey: "UserPass")
            if self.isRememberMe {
                UserDefaults.standard.set(true, forKey: "isRememberMe")
                UserDefaults.standard.set(emailAddress, forKey: "email")
                UserDefaults.standard.set(pass, forKey: "password")
            }
             let homeVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
             self.navigationController?.pushViewController(homeVC, animated: true)
            
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
    @objc func showPass(_ sender: Any) {
        if self.passTF.isSecureTextEntry {
            self.passTF.isSecureTextEntry = false
        }else {
            self.passTF.isSecureTextEntry = true
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
    
    func loginBTCongig(){
        self.loginBT.layer.cornerRadius = 5
        self.loginBT.clipsToBounds = true
        
        self.loginBT.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.175).cgColor
        self.loginBT.layer.shadowOffset = CGSize(width: 0.0, height: 8.0)
        self.loginBT.layer.shadowOpacity = 1.0
        self.loginBT.layer.shadowRadius = 4.0
        self.loginBT.layer.masksToBounds = false
    }
    func addLeftViewToPassTF(){
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "show_pass"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(passTF.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.showPass), for: .touchUpInside)
        if "lang".localized == "ar"{
//            self.passTF.leftView = button
//            self.passTF.leftViewMode = .always
        }else {
            self.passTF.rightView = button
            self.passTF.rightViewMode = .always
        }
    }
}

