//
//  AddedPlayerDetails.swift
//  GameClub
//
//  Created by Basma on 3/12/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation
import SwiftyJSON

class AddedPlayerDetails : NSObject{
    
    var id:Int?
    var update_by:Int?
    var team_id:Int?
    var location_id:Int?
    var type_id:Int?
    var link:String?
    var name:String?
    var image:String?
    var num_t_shirt:Int?
    var cost:Int?
    var is_active:Int?
    var created_at:String?
    var updated_at:String?
    var msg_add:String?
    
    override init() {
        }
        
        init(parametersJson: [String: JSON])
        {
            if let id = parametersJson["id"]?.intValue
            {
                self.id = id
            }
            
            if let update_by = parametersJson["update_by"]?.intValue
            {
                self.update_by = update_by
            }
            
            if let team_id = parametersJson["team_id"]?.intValue
            {
                self.team_id = team_id
            }
            
            if let location_id = parametersJson["location_id"]?.intValue
            {
                self.location_id = location_id
            }
            
            if let type_id = parametersJson["type_id"]?.intValue
            {
                self.type_id = type_id
            }
            
            if let link = parametersJson["link"]?.stringValue
            {
                self.link = link
            }
            
            if let name = parametersJson["name"]?.stringValue
            {
                self.name = name
            }
            
            if let image = parametersJson["point"]?.stringValue
            {
                self.image = image
            }
            
            if let num_t_shirt = parametersJson["num_t_shirt"]?.intValue
            {
                self.num_t_shirt = num_t_shirt
            }
            
            if let cost = parametersJson["cost"]?.intValue
            {
                self.cost = cost
            }
            
            if let is_active = parametersJson["is_active"]?.intValue
            {
                self.is_active = is_active
            }
            
            if let created_at = parametersJson["created_at"]?.stringValue
            {
                self.created_at = created_at
            }
            
            if let updated_at = parametersJson["updated_at"]?.stringValue
            {
                self.updated_at = updated_at
            }
            if let msg_add = parametersJson["msg_add"]?.stringValue
            {
                self.msg_add = msg_add
            }
        }
    }
