



import UIKit
import SkyFloatingLabelTextField

class ForgotPassVC: ParentViewController {
    var loginPresenter = LoginPresenter()
    @IBOutlet weak var emailTF: SkyFloatingLabelTextField!
    @IBOutlet weak var confirmEmail: UIButton!
    @IBAction func confirmPassAction(_ sender: Any) {
    }
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTF.delegate = self
        loginPresenter.loginBTCongig(loginBT: self.confirmEmail)
        if "lang".localized == "ar"{
            self.emailTF.textAlignment = .right
            self.emailTF.titleLabel.textAlignment = .right
        }else {
            self.emailTF.textAlignment = .left
            self.emailTF.titleLabel.textAlignment = .left
        }
    }
}
