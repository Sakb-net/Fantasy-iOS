



import Foundation
import SwiftyJSON
class Fixtures: NSObject {
    var end_date : String?
    var start_date : String?
    var start_date_day : String?
    var end_date_day : String?
    var match_group : [MatchGroup]?
    
    override init() {
        }
        
        init(parametersJson: [String: JSON])
        {
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
            
            if let match_group = parametersJson["match_group"]?.array
            {
                var matchGroups = [MatchGroup]()
                for match in match_group {
                    matchGroups.append(MatchGroup(parametersJson: match.dictionaryValue))
                }
                self.match_group = matchGroups
            }
        }
    }
