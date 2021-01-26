//
//  FormModel.swift
//  SAKB FANTASY
//
//  Created by Basma on 1/23/21.
//  Copyright © 2021 Basma. All rights reserved.
//

import Foundation
import SwiftyJSON

class FormModel : NSObject {
    var location_type : String?
    var state : String?
    var state_lang : String?
    var match_link : String?
    var first_team_name : String?
    var first_team_image : String?
    var first_team_goon : String?
    var second_team_name : String?
    var second_team_image : String?
    var second_team_goon : String?
    var date_day : String?
    
    override init() {
        
    }
    
    init(parametersJson: [String: JSON])
    {
        if let location_type = parametersJson["location_type"]?.stringValue
        {
            self.location_type = location_type
        }
        if let state = parametersJson["state"]?.stringValue
        {
            self.state = state
        }
        if let state_lang = parametersJson["state_lang"]?.stringValue
        {
            self.state_lang = state_lang
        }
        if let match_link = parametersJson["match_link"]?.stringValue
        {
            self.match_link = match_link
        }
        if let first_team_name = parametersJson["first_team_name"]?.stringValue
        {
            self.first_team_name = first_team_name
        }
        if let first_team_image = parametersJson["first_team_image"]?.stringValue
        {
            self.first_team_image = first_team_image
        }
        if let first_team_goon = parametersJson["first_team_goon"]?.stringValue
        {
            self.first_team_goon = first_team_goon
        }
        if let second_team_name = parametersJson["second_team_name"]?.stringValue
        {
            self.second_team_name = second_team_name
        }
        if let second_team_image = parametersJson["second_team_image"]?.stringValue
        {
            self.second_team_image = second_team_image
        }
        if let second_team_goon = parametersJson["second_team_goon"]?.stringValue
        {
            self.second_team_goon = second_team_goon
        }
        if let date_day = parametersJson["date_day"]?.stringValue
        {
            self.date_day = date_day
        }
        
    }
}
