//
//  MyTeam.swift
//  GameClub
//
//  Created by Basma on 3/13/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation
import SwiftyJSON

class MyTeam : NSObject {
    
    var found_player:Int?
    var empty_class:String?
    var currency:String?
    var eldwry_name:String?
    var eldwry_link:String?
    var team:String?
    var name_player:String?
    var cost_player:Int?
    var point_player:Int?
    var state_player:String?
    var image_player:String?
    var link_player:String?
    var location_key_player:String?
    var public_cla:String?
    var location_player:String?
    var type_player:String?
    var type_coatch:String?
    var type_key_coatch:String?
    var type_loc_player:String?
    var created_at:String?
    
    override init() {
               }
        
               init(parametersJson: [String: JSON])
               {
                   if let found_player = parametersJson["found_player"]?.intValue
                   {
                       self.found_player = found_player
                   }
                   
                   if let empty_class = parametersJson["empty_class"]?.stringValue
                   {
                       self.empty_class = empty_class
                   }
                   
                   if let currency = parametersJson["currency"]?.stringValue
                   {
                       self.currency = currency
                   }
                   
                   if let eldwry_name = parametersJson["eldwry_name"]?.stringValue
                   {
                       self.eldwry_name = eldwry_name
                   }
                   
                   if let eldwry_link = parametersJson["eldwry_link"]?.stringValue
                   {
                       self.eldwry_link = eldwry_link
                   }
                
                if let team = parametersJson["team"]?.stringValue
                {
                    self.team = team
                }
                
                if let name_player = parametersJson["name_player"]?.stringValue
                   {
                       self.name_player = name_player
                   }
                   
                   if let cost_player = parametersJson["cost_player"]?.intValue
                   {
                       self.cost_player = cost_player
                   }
                   
                   if let point_player = parametersJson["point_player"]?.intValue
                   {
                       self.point_player = point_player
                   }
                   
                   if let state_player = parametersJson["state_player"]?.stringValue
                   {
                       self.state_player = state_player
                   }
                   
                   if let image_player = parametersJson["image_player"]?.stringValue
                   {
                       self.image_player = image_player
                   }
                
                if let link_player = parametersJson["link_player"]?.stringValue
                {
                    self.link_player = link_player
                }
                
                if let location_key_player = parametersJson["location_key_player"]?.stringValue
                {
                    self.location_key_player = location_key_player
                }
                
                if let public_cla = parametersJson["public_cla"]?.stringValue
                   {
                       self.public_cla = public_cla
                   }
                   
                   if let location_player = parametersJson["location_player"]?.stringValue
                   {
                       self.location_player = location_player
                   }
                   
                   if let type_player = parametersJson["type_player"]?.stringValue
                   {
                       self.type_player = type_player
                   }
                   
                   if let type_coatch = parametersJson["type_coatch"]?.stringValue
                   {
                       self.type_coatch = type_coatch
                   }
                   
                   if let type_key_coatch = parametersJson["type_key_coatch"]?.stringValue
                   {
                       self.type_key_coatch = type_key_coatch
                   }
                
                if let type_loc_player = parametersJson["type_loc_player"]?.stringValue
                {
                    self.type_loc_player = type_loc_player
                }
                
                if let created_at = parametersJson["created_at"]?.stringValue
                {
                    self.created_at = created_at
                }
        }
    }
