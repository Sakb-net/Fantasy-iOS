//
//  Player.swift
//  GameClub
//
//  Created by Basma on 3/8/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation
import SwiftyJSON
class Player : NSObject{
        var link:String?
        var image:String?
        var name:String?
        var team:String?
        var type_player:String?
        var location_player:String?
        var cost:Int?
        var point:Int?
        var state_player:String?
        
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
            
            if let team = parametersJson["team"]?.stringValue
            {
                self.team = team
            }
            
            if let type_player = parametersJson["type_player"]?.stringValue
            {
                self.type_player = type_player
            }
            
            if let location_player = parametersJson["location_player"]?.stringValue
            {
                self.location_player = location_player
            }
            
            if let cost = parametersJson["cost"]?.intValue
            {
                self.cost = cost
            }
            
            if let point = parametersJson["point"]?.intValue
            {
                self.point = point
            }
            
            if let state_player = parametersJson["state_player"]?.stringValue
            {
                self.state_player = state_player
            }
        }
    }
