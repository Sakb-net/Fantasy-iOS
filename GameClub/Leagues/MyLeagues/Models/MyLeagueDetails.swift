//
//  MyLeagueDetails.swift
//  GameClub
//
//  Created by Basma on 10/1/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation
import SwiftyJSON

class MyLeagueDetails : NSObject {
    
    var group_eldwry : MyLeague?
    var users_group : [LeaguePlayer]?
    
    override init() {
    }
    
    init(parametersJson: [String: JSON])
    {
        
        if let group_eldwry = parametersJson["group_eldwry"]?.dictionaryValue
        {
            self.group_eldwry = MyLeague(parametersJson: group_eldwry)
        }
        
        if let users_group = parametersJson["users_group"]?.array
        {
            var playersList = [LeaguePlayer]()
            for player in users_group {
                playersList.append(LeaguePlayer(parametersJson: player.dictionaryValue))
            }
            self.users_group = playersList
        }
    }
}
