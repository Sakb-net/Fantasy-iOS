//
//  MatchGroupStandings.swift
//  GameClub
//
//  Created by Basma on 11/21/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation
import SwiftyJSON

class MatchGroupStandings : NSObject {
    var first_team_name : String?
    var first_user_name : String?
    var first_team_points : String?
    var first_team_bouns : String?
    var second_team_name : String?
    var second_user_name : String?
    var second_team_points : String?
    var second_team_bouns : String?
    var sort : String?
    var name_group : String?
    var link_group : String?
    var num_week : String?
    var lang_num_week : String?
    var subeldwry_link : String?
    
    override init() {
        
    }
    
    init(parametersJson: [String: JSON])
    {
        if let first_team_name = parametersJson["first_team_name"]?.stringValue
        {
            self.first_team_name = first_team_name
        }
        if let first_user_name = parametersJson["first_user_name"]?.stringValue
        {
            self.first_user_name = first_user_name
        }
        if let first_team_points = parametersJson["first_team_points"]?.stringValue
        {
            self.first_team_points = first_team_points
        }
        if let first_team_bouns = parametersJson["first_team_bouns"]?.stringValue
        {
            self.first_team_bouns = first_team_bouns
        }
        if let second_team_name = parametersJson["second_team_name"]?.stringValue
        {
            self.second_team_name = second_team_name
        }
        if let second_user_name = parametersJson["second_user_name"]?.stringValue
        {
            self.second_user_name = second_user_name
        }
        if let second_team_points = parametersJson["second_team_points"]?.stringValue
        {
            self.second_team_points = second_team_points
        }
        if let second_team_bouns = parametersJson["second_team_bouns"]?.stringValue
        {
            self.second_team_bouns = second_team_bouns
        }
        if let sort = parametersJson["sort"]?.stringValue
        {
            self.sort = sort
        }
        if let name_group = parametersJson["name_group"]?.stringValue
        {
            self.name_group = name_group
        }
        if let link_group = parametersJson["link_group"]?.stringValue
        {
            self.link_group = link_group
        }
        if let num_week = parametersJson["num_week"]?.stringValue
        {
            self.num_week = num_week
        }
        if let lang_num_week = parametersJson["lang_num_week"]?.stringValue
        {
            self.lang_num_week = lang_num_week
        }
        if let subeldwry_link = parametersJson["subeldwry_link"]?.stringValue
        {
            self.subeldwry_link = subeldwry_link
        }
    }

}
