//
//  PublicPoints.swift
//  GameClub
//
//  Created by Basma on 7/4/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation
import SwiftyJSON

class PublicPoints : NSObject {
    
    var sum_total_points : Int?
    var sort_final_users : Int?
    var count_total_users : Int?
    var sum_total_subeldwry : Int?
    var game_week_changes : Int?
    var total_changes : Int?

    override init() {
           }

           init(parametersJson: [String: JSON])
           {
               if let sum_total_points = parametersJson["sum_total_points"]?.intValue
               {
                   self.sum_total_points = sum_total_points
               }
            
            if let sort_final_users = parametersJson["sort_final_users"]?.intValue
            {
                self.sort_final_users = sort_final_users
            }
            
            if let count_total_users = parametersJson["count_total_users"]?.intValue
            {
                self.count_total_users = count_total_users
            }
            
            if let sum_total_subeldwry = parametersJson["sum_total_subeldwry"]?.intValue
            {
                self.sum_total_subeldwry = sum_total_subeldwry
            }
            
            if let game_week_changes = parametersJson["game_week_changes"]?.intValue
            {
                self.game_week_changes = game_week_changes
            }
            
            if let total_changes = parametersJson["total_changes"]?.intValue
            {
                self.total_changes = total_changes
            }
    }
}
