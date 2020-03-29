


import UIKit
import SwiftyJSON

class News: NSObject {
    
    var name:String?
    var link:String?
    var image:String?
    var content:String?
    var desc:String?
    var date:String?
    var created_at:String?
    
    override init() {
    }
    
    init(parametersJson: [String: JSON])
    {
        if let link = parametersJson["link"]?.stringValue
        {
            self.link = link
        }
        
        if let name = parametersJson["name"]?.stringValue
        {
            self.name = name
        }
        
        if let image = parametersJson["image"]?.stringValue
        {
            self.image = image
        }
        
        if let content = parametersJson["content"]?.stringValue
        {
            self.content = content
        }
        
        if let desc = parametersJson["description"]?.stringValue
        {
            self.desc = desc
        }
        
        if let date = parametersJson["date"]?.stringValue
        {
            self.date = date
        }
        
        if let created_at = parametersJson["created_at"]?.stringValue
        {
            self.created_at = created_at
        }
    }
}
