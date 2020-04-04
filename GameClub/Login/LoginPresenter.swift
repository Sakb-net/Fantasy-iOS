




import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import TwitterKit
class LoginPresenter {
    
    func userLogin(email:String, password:String, onSuccess: @escaping (User) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getLoginURL()
        
        let parameters:[String:Any] = [
            "email_user_name": email,
            "password": password
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 0 {
                    let data = response!["data"]
                    let user = User(parametersJson: data.dictionaryValue)
                    print(user.access_token)
                    UserDefaults.standard.set(user.access_token, forKey: "access_token")
                    user.saveUser()
                    onSuccess(User.shared())
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
    
    func userRegister(email:String, password:String, displayName:String, phone:String,  city:String, reg_site:String, onSuccess: @escaping (User) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getRegisterURL()
        
        let parameters:[String:Any] = [
            "display_name": displayName,
            "phone": phone,
            "email": email,
            "country": "SA",
            "city": city,
            "state": reg_site,
            "reg_site": reg_site,
            "password": password
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 0 {
                    let data = response!["data"]
                    let user = User(parametersJson: data.dictionaryValue)
                    user.saveUser()
                    onSuccess(User.shared())
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
    
    func facebookLogin (vc : UIViewController){
        let loginManager = LoginManager()
        UIApplication.shared.statusBarStyle = .default  // remove this line if not required
        loginManager.logIn(permissions: ["public_profile","email"], from: vc) { (loginResult, error) in
            print(loginResult)
            
            //use picture.type(large) for large size profile picture
            let request = GraphRequest(graphPath: "me", parameters: ["fields":"id, email, name, gender, picture.width(480).height(480)"], tokenString: AccessToken.current?.tokenString, version: nil, httpMethod: HTTPMethod(rawValue: "GET"))
            request.start(completionHandler: { (test, result, error) in
                if(error == nil)
                {
                    let info = result as! NSDictionary
                    print(info)
                    print(info["email"])
                }
            })
            
            
        }
    }
    
    func twitterLogin() {
        TWTRTwitter.sharedInstance().logIn { (session, error) in
            if (session != nil) {
                let client = TWTRAPIClient.withCurrentUser()
                client.requestEmail { email, error in
                    if (email != nil) {
                        let username = session?.userName
                        print("signed in with email \(String(describing: email))")
                        print("signed in with tokken \(String(describing: session?.authToken))")
                        print("signed in with userID \(String(describing: session?.userID))")
                        
                    }else {
                        print("twitter_error: \(String(describing: error?.localizedDescription))");
                    }
                }
                client.loadUser(withID: session?.userID ?? "", completion: { (user, error) in
                    print("user's name: \(user?.name ?? "")")
                    print("user's name: \(user?.userID ?? "")")
                    print("user's profile picture: \(user?.profileImageURL ?? "")")
                })
            }else {
                print("error: \(String(describing: error?.localizedDescription))");
            }
        }
        
    }
    
    func loginBTCongig(loginBT : UIView){
        loginBT.layer.cornerRadius = 10
        loginBT.clipsToBounds = true
        
        loginBT.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.175).cgColor
        loginBT.layer.shadowOffset = CGSize(width: 0.0, height: 8.0)
        loginBT.layer.shadowOpacity = 1.0
        loginBT.layer.shadowRadius = 4.0
        loginBT.layer.masksToBounds = false
    }
    
}