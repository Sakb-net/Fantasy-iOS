//
//  FixturesDetailsItemModel.swift
//  GameClub
//
//  Created by Basma on 8/8/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation
import SwiftyJSON
class FixturesDetailsItemModel : NSObject {
    
    var first_team : [FixturesDetailsTeamsModel]?
    var second_team : [FixturesDetailsTeamsModel]?
        
        override init() {
        }
        init(parametersJson: [String: JSON]) {
            if let first_team = parametersJson["first_team"]?.arrayValue
            {
                    var items = [FixturesDetailsTeamsModel]()
                    for item in first_team {
                        items.append(FixturesDetailsTeamsModel(parametersJson: item.dictionaryValue))
                    }
                    self.first_team = items
            }
            
            if let second_team = parametersJson["second_team"]?.arrayValue
            {
                var items = [FixturesDetailsTeamsModel]()
                for item in second_team {
                    items.append(FixturesDetailsTeamsModel(parametersJson: item.dictionaryValue))
                }
                self.second_team = items
            }
        }
    }
