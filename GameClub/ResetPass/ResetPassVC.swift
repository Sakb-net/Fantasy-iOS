




import UIKit
import SkyFloatingLabelTextField

class ResetPassVC: UIViewController {
    
    var loginPresenter = LoginPresenter()

    @IBOutlet weak var passTF: SkyFloatingLabelTextField!
    @IBOutlet weak var confirmPassTF: SkyFloatingLabelTextField!
    @IBOutlet weak var savePassBT: UIButton!
    @IBAction func savePassAction(_ sender: Any) {
    }
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loginPresenter.loginBTCongig(loginBT: self.savePassBT)
        self.passTF.textAlignment = .right
        self.passTF.titleLabel.textAlignment = .right
        self.confirmPassTF.textAlignment = .right
        self.confirmPassTF.titleLabel.textAlignment = .right
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
        self.passTF.leftView = button
        self.passTF.leftViewMode = .always
        self.confirmPassTF.leftView = button2
        self.confirmPassTF.leftViewMode = .always
        
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
        if self.passTF.text != "" {
            if self.confirmPassTF.isSecureTextEntry {
                self.confirmPassTF.isSecureTextEntry = false
            }else {
                self.confirmPassTF.isSecureTextEntry = true
            }
        }
    }
}
