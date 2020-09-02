//
//  PlayerStatistics.swift
//  GameClub
//
//  Created by Basma on 6/30/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation
import SwiftyJSON

class PlayerStatistics : NSObject{
    var isOpended : Bool?
    var link_match : String?
    var againestTeam : String?
    var ownTeam : String?
    var againestTeamResult : Int?
    var ownTeamResult : Int?
    var minsPlayed : Int?
    var goals : Int?
    var week : Int?
    var keyPass : Int?
    var redCard : Int?
    var yellowCard : Int?
    var goalAssist : Int?
    var saves : Int?
    var cleanSheet : Int?
    var points : Int?
    var reverseGoal : Int?
    var penalitySave : Int?
    var penalityLost : Int?
    var extraPoints : Int?
    var statistic : [PlayerSubStatsModel]?

    override init() {
    }
    
    init(parametersJson: [String: JSON])
    {
        if let link_match = parametersJson["link_match"]?.stringValue
        {
            self.link_match = link_match
        }
        
        if let againestTeam = parametersJson["againestTeam"]?.stringValue
        {
            self.againestTeam = againestTeam
        }
        
        if let ownTeam = parametersJson["ownTeam"]?.stringValue
        {
            self.ownTeam = ownTeam
        }
        
        if let againestTeamResult = parametersJson["againestTeamResult"]?.intValue
        {
            self.againestTeamResult = againestTeamResult
        }
        
        if let ownTeamResult = parametersJson["ownTeamResult"]?.intValue
        {
            self.ownTeamResult = ownTeamResult
        }
        
        if let minsPlayed = parametersJson["minsPlayed"]?.intValue
        {
            self.minsPlayed = minsPlayed
        }
        
        if let goals = parametersJson["goals"]?.intValue
        {
            self.goals = goals
        }
        
        if let week = parametersJson["week"]?.intValue
        {
            self.week = week
        }
        
        if let keyPass = parametersJson["keyPass"]?.intValue
        {
            self.keyPass = keyPass
        }
        
        if let redCard = parametersJson["redCard"]?.intValue
        {
            self.redCard = redCard
        }
        
        if let yellowCard = parametersJson["yellowCard"]?.intValue
        {
            self.yellowCard = yellowCard
        }
        
        if let goalAssist = parametersJson["goalAssist"]?.intValue
        {
            self.goalAssist = goalAssist
        }
        
        if let saves = parametersJson["saves"]?.intValue
        {
            self.saves = saves
        }
        
        if let cleanSheet = parametersJson["cleanSheet"]?.intValue
        {
            self.cleanSheet = cleanSheet
        }
        
        if let points = parametersJson["points"]?.intValue
        {
            self.points = points
        }
        
        if let reverseGoal = parametersJson["reverseGoal"]?.intValue
        {
            self.reverseGoal = reverseGoal
        }
        
        if let penalitySave = parametersJson["penalitySave"]?.intValue
        {
            self.penalitySave = penalitySave
        }
        
        if let penalityLost = parametersJson["penalityLost"]?.intValue
        {
            self.penalityLost = penalityLost
        }
        
        if let extraPoints = parametersJson["extraPoints"]?.intValue
        {
            self.extraPoints = extraPoints
        }
        
        if let statistic = parametersJson["statistic"]?.arrayValue
        {
            var items = [PlayerSubStatsModel]()
            for item in statistic {
                items.append(PlayerSubStatsModel(parametersJson: item.dictionaryValue))
            }
            self.statistic = items
        }
    }
}
