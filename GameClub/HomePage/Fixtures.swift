



import Foundation
import SwiftyJSON
class Fixtures: NSObject {
    var end_date : String?
    var start_date : String?
    var start_date_day : String?
    var end_date_day : String?
    var desc:String?
    var date:String?
    var date_day:String?
    var time:String?
    var first_goon:Int?
    var second_goon:Int?
    var name_first:String?
    var name_second:String?
    var link_first:String?
    var link_second:String?
    var image_second:String?
    var image_first:String?
    var code_first:String?
    var code_second:String?
    var details :DetailsModel?
    override init() {
    }
    
    init(parametersJson: [String: JSON])
    {
        if let code_first = parametersJson["code_first"]?.stringValue
        {
            self.code_first = code_first
        }
        if let code_second = parametersJson["code_second"]?.stringValue
        {
            self.code_second = code_second
        }
        if let end_date = parametersJson["end_date"]?.stringValue
        {
            self.end_date = end_date
        }
        
        if let start_date = parametersJson["start_date"]?.stringValue
        {
            self.start_date = start_date
        }
        
        if let start_date_day = parametersJson["start_date_day"]?.stringValue
        {
            self.start_date_day = start_date_day
        }
        
        if let end_date_day = parametersJson["end_date_day"]?.stringValue
        {
            self.end_date_day = end_date_day
        }
        
        if let desc = parametersJson["description"]?.stringValue
        {
            self.desc = desc
        }
        
        if let date = parametersJson["date"]?.stringValue
        {
            self.date = date
        }
        
        if let date_day = parametersJson["date_day"]?.stringValue
        {
            self.date_day = date_day
        }
        
        if let time = parametersJson["time"]?.stringValue
        {
            self.time = time
        }
        
        if let first_goon = parametersJson["first_goon"]?.intValue
        {
            self.first_goon = first_goon
        }
        
        if let second_goon = parametersJson["second_goon"]?.intValue
        {
            self.second_goon = second_goon
        }
        
        if let name_first = parametersJson["name_first"]?.stringValue
        {
            self.name_first = name_first
        }
        
        if let name_second = parametersJson["name_second"]?.stringValue
        {
            self.name_second = name_second
        }
        
        if let link_first = parametersJson["link_first"]?.stringValue
        {
            self.link_first = link_first
        }
        
        if let link_second = parametersJson["link_second"]?.stringValue
        {
            self.link_second = link_second
        }
        
        if let image_second = parametersJson["image_second"]?.stringValue
        {
            self.image_second = image_second
        }
        
        if let image_first = parametersJson["image_first"]?.stringValue
        {
            self.image_first = image_first
        }
        
        if let details = parametersJson["details"]?.dictionaryValue
        {
            self.details = DetailsModel(parametersJson: details)
        }
    }
}
