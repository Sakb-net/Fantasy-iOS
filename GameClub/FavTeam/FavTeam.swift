



import Foundation
import SwiftyJSON

class FavTeam : NSObject{
        var name:String?
        var link:String?
        
        override init() {
        }
        
        init(parametersJson: [String: JSON])
        {
            if let name = parametersJson["name"]?.stringValue
            {
                self.name = name
            }
            
            if let link = parametersJson["link"]?.stringValue
            {
                self.link = link
            }
            
        }
    }
