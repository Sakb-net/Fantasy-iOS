//
//  LeaguePlayer.swift
//  GameClub
//
//  Created by Basma on 10/1/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation
import SwiftyJSON

class LeaguePlayer : NSObject {

    var user_id : Int?
    var user_name : String?
    var display_name : String?
    var user_email : String?
    var name_team : String?
    var name_group : String?
    var link_group : String?
    var points : String?
    var total_points : String?
    var gw_points : String?
    var sort : String?
    var num_week : String?
    var lang_num_week : String?
    var subeldwry_link : String?
    
    override init() {
        
    }
    
    init(parametersJson: [String: JSON])
    {
        if let gw_points = parametersJson["gw_points"]?.stringValue
        {
            self.gw_points = gw_points
        }
        
        if let total_points = parametersJson["total_points"]?.stringValue
        {
            self.total_points = total_points
        }
        
        if let sort = parametersJson["sort"]?.stringValue
        {
            self.sort = sort
        }
        
        if let user_id = parametersJson["user_id"]?.intValue
        {
            self.user_id = user_id
        }
        
        if let user_name = parametersJson["user_name"]?.stringValue
        {
            self.user_name = user_name
        }
        
        if let display_name = parametersJson["display_name"]?.stringValue
        {
            self.display_name = display_name
        }
        
        if let name_team = parametersJson["name_team"]?.stringValue
        {
            self.name_team = name_team
        }
        
        if let name_group = parametersJson["name_group"]?.stringValue
        {
            self.name_group = name_group
        }
        
        if let link_group = parametersJson["link_group"]?.stringValue
        {
            self.link_group = link_group
        }
        
        if let points = parametersJson["points"]?.stringValue
        {
            self.points = points
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
