



import UIKit
import SideMenu

class ContactUsVC: ParentViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var contentTV: UITextView!
    @IBOutlet weak var sendBT: UIButton!
    @IBAction func SendAction(_ sender: Any) {
        sendMessage(content: self.contentTV.text, onSuccess: { (message) in
            self.showAlert(title: "", message: message, shouldpop: false)
            self.contentTV.text = ""
        }) { (errorMessage) in
        }
    }
    
    @IBAction func menuAction(_ sender: Any) {
        let menu = storyboard!.instantiateViewController(withIdentifier: "RightMenu") as! UISideMenuNavigationController
        present(menu, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adjustingDesign()
        getConacts(onSuccess: { (email,phone) in
            self.emailLabel.text = email
            self.phoneLabel.text = phone
            
        }) { (errorMessage) in
        }
    }

    func adjustingDesign(){
        roundViewCorners(view: containerView)
        self.sendBT.layer.cornerRadius = 6
        self.sendBT.clipsToBounds = true
    }
    
    func getConacts( onSuccess: @escaping (String, String) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getContacts()
        
        let parameters:[String:Any] = ["lang": HelperMethods.getCurrentLanguage()]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 0 {
                    let email = response!["data"]["email"].string!
                    let phone = response!["data"]["phone"].string!
                    onSuccess(email, phone)
                }else{
                    let message = response!["Message"].stringValue
                    onFailure(message)
                }
            }
            else
            {
                onFailure(error!.localizedDescription)
            }
        }
    }
    
    func sendMessage(content : String, onSuccess: @escaping (String) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().sendMessage()
        
        let parameters:[String:Any] = [
            "content" : content,
            "lang": HelperMethods.getCurrentLanguage()
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 0 {
                    let message = response!["Message"].stringValue
                    onSuccess(message)
                }else{
                    let message = response!["Message"].stringValue
                    onFailure(message)
                }
            }
            else
            {
                onFailure("Something went wrong try again later!".localized)
            }
        }
    }
    
}
