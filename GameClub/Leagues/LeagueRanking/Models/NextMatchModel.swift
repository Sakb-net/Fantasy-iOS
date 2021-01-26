//
//  LastMatchModel.swift
//  SAKB FANTASY
//
//  Created by Basma on 1/23/21.
//  Copyright © 2021 Basma. All rights reserved.
//

import Foundation
import SwiftyJSON

class NextMatchModel : NSObject {
    
    var match_link : String?
    var second_team_link : String?
    var second_team_name : String?
    var second_team_image : String?
    var date_day : String?
    var time : String?
    
    override init() {
        
    }
    
    init(parametersJson: [String: JSON])
    {
        if let match_link = parametersJson["match_link"]?.stringValue
        {
            self.match_link = match_link
        }
        if let second_team_link = parametersJson["second_team_link"]?.stringValue
        {
            self.second_team_link = second_team_link
        }
        if let second_team_name = parametersJson["second_team_name"]?.stringValue
        {
            self.second_team_name = second_team_name
        }
        if let second_team_image = parametersJson["second_team_image"]?.stringValue
        {
            self.second_team_image = second_team_image
        }
        if let date_day = parametersJson["date_day"]?.stringValue
        {
            self.date_day = date_day
        }
        if let time = parametersJson["time"]?.stringValue
        {
            self.time = time
        }
    }
}
