//
//  StatisticsModel.swift
//  GameClub
//
//  Created by Basma on 8/28/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation
import SwiftyJSON

class StatisticsModel : NSObject {
    var link : String?
    var image : String?
    var name : String?
    var team : String?
    var teamCode : String?
    var type_player : String?
    var location_player : String?
    var cost : Int?
    var sell_cost: Int?
    var buy_cost : Int?
    var is_choose : Int?
    var point : Int?
    var fix : String?
    var form : Int?
    var week : Int?
    var sel_percentage : Double?
    var influence : Int?
    var creativity : Int?
    var threats : Int?
    var ICT_index : Int?
    var state_player : String?
    var id : Int?
    var location_id : Int?
    
    override init() {
    }

    init(parametersJson: [String: JSON])
    {
        if let link = parametersJson["link"]?.stringValue
        {
            self.link = link
        }
        
        if let image = parametersJson["image"]?.stringValue
        {
            self.image = image
        }
        
        if let name = parametersJson["name"]?.stringValue
        {
            self.name = name
        }
        
        if let team = parametersJson["team"]?.stringValue
        {
            self.team = team
        }
        
        if let teamCode = parametersJson["teamCode"]?.stringValue
        {
            self.teamCode = teamCode
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
        
        if let sell_cost = parametersJson["sell_cost"]?.intValue
        {
            self.sell_cost = sell_cost
        }
        
        if let buy_cost = parametersJson["buy_cost"]?.intValue
        {
            self.buy_cost = buy_cost
        }
        
        if let is_choose = parametersJson["is_choose"]?.intValue
        {
            self.is_choose = is_choose
        }
        
        if let point = parametersJson["point"]?.intValue
        {
            self.point = point
        }
        
        if let fix = parametersJson["fix"]?.stringValue
        {
            self.fix = fix
        }
        
        if let form = parametersJson["form"]?.intValue
        {
            self.form = form
        }
        
        if let week = parametersJson["week"]?.intValue
        {
            self.week = week
        }
        
        if let sel_percentage = parametersJson["sel_percentage"]?.doubleValue
        {
            self.sel_percentage = sel_percentage
        }
        
        if let influence = parametersJson["influence"]?.intValue
        {
            self.influence = influence
        }
        
        if let creativity = parametersJson["creativity"]?.intValue
        {
            self.creativity = creativity
        }
        
        if let threats = parametersJson["threats"]?.intValue
        {
            self.threats = threats
        }
        
        if let ICT_index = parametersJson["ICT_index"]?.intValue
        {
            self.ICT_index = ICT_index
        }
        
        if let state_player = parametersJson["state_player"]?.stringValue
        {
            self.state_player = state_player
        }
        
        if let id = parametersJson["id"]?.intValue
        {
            self.id = id
        }
        
        if let location_id = parametersJson["location_id"]?.intValue
        {
            self.location_id = location_id
        }
    }
}
