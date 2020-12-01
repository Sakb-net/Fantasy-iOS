





import UIKit
import SwiftyJSON

class User: NSObject, NSCoding {
    
    var id : Int?
    var display_name: String?
    var email: String?
    var access_token: String?
    var image:String?
    var phone: String?
    var gender: String?
    var address:String?
    var city: String?
    var state:String?
    var team_name:String?
    var team_link:String?
    var new_fcm_token:String?
    var old_fcm_token:String?
    var choose_team : Int?
    
    private static var currentUser: User!
    
    private override init() {
    }
    
    class func shared() -> User {
        
        if self.currentUser == nil
        {
            if let cachedUserData = UserDefaults.standard.object(forKey: "UserCachedData") as? Data
            {
                do
                {
                    let cachedUser = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(cachedUserData) as! User
                    
                    return cachedUser
                }
                catch
                {
                    return User()
                }
                
            }else {
                return User()
            }
            
        }else {
            return self.currentUser
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.display_name, forKey: "display_name")
        aCoder.encode(self.email, forKey: "email")
        aCoder.encode(self.access_token, forKey: "access_token")
        aCoder.encode(self.image, forKey: "image")
        aCoder.encode(self.phone, forKey: "phone")
        aCoder.encode(self.gender, forKey: "gender")
        aCoder.encode(self.address, forKey: "address")
        aCoder.encode(self.city, forKey: "city")
        aCoder.encode(self.state, forKey: "state")
        aCoder.encode(self.team_name, forKey: "team_name")
        aCoder.encode(self.team_link, forKey: "team_link")
        aCoder.encode(self.new_fcm_token, forKey: "new_fcm_token")
        aCoder.encode(self.choose_team, forKey: "choose_team")

    }
    
    required init?(coder aDecoder: NSCoder) {
        self.id = (aDecoder.decodeObject(forKey: "id") as? Int) ?? 0
        self.display_name = (aDecoder.decodeObject(forKey: "display_name") as? String) ?? ""
        self.email = (aDecoder.decodeObject(forKey: "email") as? String) ?? ""
        self.access_token = (aDecoder.decodeObject(forKey: "access_token") as? String) ?? ""
        self.image = (aDecoder.decodeObject(forKey: "image") as? String) ?? ""
        self.phone = (aDecoder.decodeObject(forKey: "phone") as? String) ?? ""
        self.gender = (aDecoder.decodeObject(forKey: "gender") as? String) ?? ""
        self.address = (aDecoder.decodeObject(forKey: "address") as? String) ?? ""
        self.city = (aDecoder.decodeObject(forKey: "city") as? String) ?? ""
        self.state = (aDecoder.decodeObject(forKey: "state") as? String) ?? ""
        self.team_name = (aDecoder.decodeObject(forKey: "team_name") as? String) ?? ""
        self.team_link = (aDecoder.decodeObject(forKey: "team_link") as? String) ?? ""
        self.new_fcm_token = (aDecoder.decodeObject(forKey: "new_fcm_token") as? String) ?? ""
        self.choose_team = (aDecoder.decodeObject(forKey: "choose_team") as? Int) ?? 0
    }
    
    
    init(parametersJson: [String: JSON]) {
        
        if let id = parametersJson["id"]?.int {
            self.id = id
        }
        
        if let display_name = parametersJson["display_name"]?.string {
            self.display_name = display_name
        }
        
        if let email = parametersJson["email"]?.string {
            self.email = email
        }
        
        if let access_token = parametersJson["access_token"]?.string {
            self.access_token = access_token
        }
        
        if let image = parametersJson["image"]?.string {
            self.image = Urls.baseUrl + image
        }
        
        if let phone = parametersJson["phone"]?.string {
            self.phone = phone
        }
        
        if let gender = parametersJson["gender"]?.string {
            self.gender = gender
        }
        
        if let address = parametersJson["address"]?.string {
            self.address = address
        }
        
        if let city = parametersJson["city"]?.string {
            self.city = city
        }
        
        if let state = parametersJson["state"]?.string {
            self.state = state
        }
        
        if let team_name = parametersJson["team_name"]?.string {
            self.team_name = team_name
        }
        
        if let team_link = parametersJson["team_link"]?.string {
            self.team_link = team_link
        }
        
        if let new_fcm_token = parametersJson["new_fcm_token"]?.string {
            self.new_fcm_token = new_fcm_token
        }
        
        if let choose_team = parametersJson["choose_team"]?.int {
            self.choose_team = choose_team
        }
    }
    
    func saveUser()
    {
        do {
            let encodedObject = try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
            UserDefaults.standard.set(encodedObject, forKey: "UserCachedData")
            UserDefaults.standard.synchronize()
        }catch {
            print("Error")
        }
    }
    
    func logoutUser()
    {
        let defaults = UserDefaults.standard
        defaults.set("0", forKey: "UnReadNotificationsCount")
        defaults.removeObject(forKey: "UserCachedData")
    }
}
