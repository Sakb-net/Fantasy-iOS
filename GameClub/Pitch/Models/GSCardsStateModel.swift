//
//  GSCardsStateModel.swift
//  GameClub
//
//  Created by Basma on 9/12/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation
import SwiftyJSON

class GSCardsStateModel : NSObject {
    
    var total_team_play : Int?
    var remide_sum_cost : Int?
    var pay_total_cost : Int?
    var total_cost_play : Int?
    var substitutes_points : Int?
    var active_card : Int?
    
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
        
        if let pay_total_cost = parametersJson["pay_total_cost"]?.intValue
        {
            self.pay_total_cost = pay_total_cost
        }
        
        if let total_cost_play = parametersJson["total_cost_play"]?.intValue
        {
            self.total_cost_play = total_cost_play
        }
        
        if let substitutes_points = parametersJson["substitutes_points"]?.intValue
        {
            self.substitutes_points = substitutes_points
        }
        
        if let active_card = parametersJson["active_card"]?.intValue
        {
            self.active_card = active_card
        }
        
    }
}
