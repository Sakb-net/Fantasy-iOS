//
//  LeagueStandingsModel.swift
//  GameClub
//
//  Created by Basma on 10/10/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation
import SwiftyJSON

class LeagueStandingsModel : NSObject {
    
    var group_eldwry : MyLeague?
    var owner : Int?
    var users_group : [LeaguePlayer]?
    var matches_group : [MatchGroupStandings]?
    override init() {
        
    }
    
    init(parametersJson: [String: JSON])
    {
        if let group_eldwry = parametersJson["group_eldwry"]?.dictionaryValue
        {
            self.group_eldwry = MyLeague(parametersJson: group_eldwry)
        }
        
        if let owner = parametersJson["owner"]?.intValue
        {
            self.owner = owner
        }
        if let users_group = parametersJson["users_group"]?.array
        {
            var playersList = [LeaguePlayer]()
            for player in users_group {
                playersList.append(LeaguePlayer(parametersJson: player.dictionaryValue))
            }
            self.users_group = playersList
        }
        if let matches_group = parametersJson["matches_group"]?.array
        {
            var matchesList = [MatchGroupStandings]()
            for match in matches_group {
                matchesList.append(MatchGroupStandings(parametersJson: match.dictionaryValue))
            }
            self.matches_group = matchesList
        }
    }
}
