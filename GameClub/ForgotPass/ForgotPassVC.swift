



import UIKit
import SkyFloatingLabelTextField

class ForgotPassVC: UIViewController {
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
        loginPresenter.loginBTCongig(loginBT: self.confirmEmail)
        self.emailTF.textAlignment = .right
        self.emailTF.titleLabel.textAlignment = .right
    }
}
