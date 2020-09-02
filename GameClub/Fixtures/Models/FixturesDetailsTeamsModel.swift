//
//  FixturesDetailsTeamsModel.swift
//  GameClub
//
//  Created by Basma on 8/7/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation
import SwiftyJSON

class FixturesDetailsTeamsModel : NSObject {
    var player_name : String?
    var player_link : String?
    var value : Int?
    
    override init() {
                 }
       init(parametersJson: [String: JSON])
                  {
                   if let player_name = parametersJson["player_name"]?.stringValue
                   {
                       self.player_name = player_name
                   }
                    
                    if let player_link = parametersJson["player_link"]?.stringValue
                    {
                        self.player_link = player_link
                    }
                    
                    if let value = parametersJson["value"]?.intValue
                    {
                        self.value = value
                    }
    }
}
