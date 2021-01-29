//
//  LeagueRankingModel.swift
//  SAKB FANTASY
//
//  Created by Basma on 1/23/21.
//  Copyright © 2021 Basma. All rights reserved.
//

import Foundation
import SwiftyJSON

class LeagueRankingModel : NSObject {
    var filterType = "no"
    var isOpend = false
    var index : String?
    var team_link : String?
    var team_name : String?
    var team_code : String?
    var team_image : String?
    var site_team : String?
    var count_played : String?
    var won : String?
    var draw : String?
    var loss : String?
    var goals_own : String?
    var goals_aganist : String?
    var goals_diff : String?
    var points : String?
    var class_state : String?
    var form : [FormModel]?
    var current_match : FormModel?
    var next_match : NextMatchModel?
    
    override init() {
        
    }
    
    init(parametersJson: [String: JSON])
    {
        if let team_link = parametersJson["team_link"]?.stringValue
        {
            self.team_link = team_link
        }
        if let team_name = parametersJson["team_name"]?.stringValue
        {
            self.team_name = team_name
        }
        if let team_code = parametersJson["team_code"]?.stringValue
        {
            self.team_code = team_code
        }
        if let team_image = parametersJson["team_image"]?.stringValue
        {
            self.team_image = team_image
        }
        if let site_team = parametersJson["site_team"]?.stringValue
        {
            self.site_team = site_team
        }
        if let count_played = parametersJson["count_played"]?.stringValue
        {
            self.count_played = count_played
        }
        if let won = parametersJson["won"]?.stringValue
        {
            self.won = won
        }
        if let draw = parametersJson["draw"]?.stringValue
        {
            self.draw = draw
        }
        if let loss = parametersJson["loss"]?.stringValue
        {
            self.loss = loss
        }
        if let goals_own = parametersJson["goals_own"]?.stringValue
        {
            self.goals_own = goals_own
        }
        if let goals_aganist = parametersJson["goals_aganist"]?.stringValue
        {
            self.goals_aganist = goals_aganist
        }
        if let goals_diff = parametersJson["goals_diff"]?.stringValue
        {
            self.goals_diff = goals_diff
        }
        if let points = parametersJson["points"]?.stringValue
        {
            self.points = points
        }
        if let class_state = parametersJson["class_state"]?.stringValue
        {
            self.class_state = class_state
        }
        if let form = parametersJson["form"]?.array
        {
            var forms = [FormModel]()
            for item in form {
                forms.append(FormModel(parametersJson: item.dictionaryValue))
            }
            self.form = forms
        }
        if let current_match = parametersJson["current_match"]?.dictionaryValue
        {
            self.current_match = FormModel(parametersJson: current_match)
        }
        if let next_match = parametersJson["next_match"]?.dictionaryValue
        {
            self.next_match = NextMatchModel(parametersJson: next_match)
        }
    }
}


