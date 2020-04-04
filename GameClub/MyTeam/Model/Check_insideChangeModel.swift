//
//  check_insideChange.swift
//  GameClub
//
//  Created by Basma on 4/4/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation
import SwiftyJSON
class Check_insideChangeModel : NSObject {
    
    var type_loc_player : String?
    var all_hide : Int?
    var msg_add : String?
    var ok_add : Int?
    var change : Int?
    var first_choose : Int?
    var second_choose : Int?
    var type_loc_player_one : String?
    var type_loc_player_two : String?
    var ch_game_player_id_one : Int?
    var ch_player_id_one : Int?
    var ch_game_player_id_two : Int?
    var ch_player_id_two : Int?
    
    override init() {
    }
    
    init(parametersJson: [String: JSON])
    {
        
        if let type_loc_player = parametersJson["type_loc_player"]?.stringValue
        {
            self.type_loc_player = type_loc_player
        }
        
        if let all_hide = parametersJson["all_hide"]?.intValue
        {
            self.all_hide = all_hide
        }
        
        if let msg_add = parametersJson["msg_add"]?.stringValue
        {
            self.msg_add = msg_add
        }
        
        if let ok_add = parametersJson["ok_add"]?.intValue
        {
            self.ok_add = ok_add
        }
        
        if let change = parametersJson["change"]?.intValue
        {
            self.change = change
        }
        
        if let first_choose = parametersJson["first_choose"]?.intValue
        {
            self.first_choose = first_choose
        }
        
        if let second_choose = parametersJson["second_choose"]?.intValue
        {
            self.second_choose = second_choose
        }
        
        if let type_loc_player_one = parametersJson["type_loc_player_one"]?.stringValue
        {
            self.type_loc_player_one = type_loc_player_one
        }
        
        if let type_loc_player_two = parametersJson["type_loc_player_two"]?.stringValue
        {
            self.type_loc_player_two = type_loc_player_two
        }
        
        if let ch_game_player_id_one = parametersJson["ch_game_player_id_one"]?.intValue
        {
            self.ch_game_player_id_one = ch_game_player_id_one
        }
        
        if let ch_player_id_one = parametersJson["ch_player_id_one"]?.intValue
        {
            self.ch_player_id_one = ch_player_id_one
        }
        
        if let ch_game_player_id_two = parametersJson["ch_game_player_id_two"]?.intValue
        {
            self.ch_game_player_id_two = ch_game_player_id_two
        }
        
        if let ch_player_id_two = parametersJson["ch_player_id_two"]?.intValue
        {
            self.ch_player_id_two = ch_player_id_two
        }
        
    }
    
}
