//
//  AddedPlayerData.swift
//  GameClub
//
//  Created by Basma on 3/12/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation
import SwiftyJSON

class AddedPlayerData : NSObject {
    var total_team_play:Int?
    var remide_sum_cost:Int?
    var add_player:Int?
    var msg_add:String?
    var val_player:String?
    var player_data:AddedPlayerDetails?
    override init() {
           }
    
           init(parametersJson: [String: JSON])
           {
               if let total_team_play = parametersJson["total_team_play"]?.intValue
               {
                   self.total_team_play = total_team_play
               }
               
               if let remide_sum_cost = parametersJson["remide_sum_cost"]?.intValue
               {
                   self.remide_sum_cost = remide_sum_cost
               }
               
               if let add_player = parametersJson["add_player"]?.intValue
               {
                   self.add_player = add_player
               }
               
               if let msg_add = parametersJson["msg_add"]?.stringValue
               {
                   self.msg_add = msg_add
               }
               
               if let val_player = parametersJson["val_player"]?.stringValue
               {
                   self.val_player = val_player
               }
            
            if let player_data = parametersJson["player_data"]?.object
            {
                self.player_data = player_data as? AddedPlayerDetails
            }
    }
}
