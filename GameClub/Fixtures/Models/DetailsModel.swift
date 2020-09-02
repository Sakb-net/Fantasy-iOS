//
//  DetailsModel.swift
//  GameClub
//
//  Created by Basma on 8/8/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation
import SwiftyJSON

class DetailsModel : NSObject{
    var goalsConceded : FixturesDetailsItemModel?
    var saves : FixturesDetailsItemModel?
    var goals : FixturesDetailsItemModel?
    var goalAssist : FixturesDetailsItemModel?
    var yellowCard : FixturesDetailsItemModel?
    var redCard : FixturesDetailsItemModel?
    var bouns : FixturesDetailsItemModel?
    override init() {
           }
           
           init(parametersJson: [String: JSON])
           {
            if let goalsConceded = parametersJson["goalsConceded"]?.dictionaryValue
            {
                self.goalsConceded = FixturesDetailsItemModel(parametersJson: goalsConceded)
            }
            if let saves = parametersJson["saves"]?.dictionaryValue
            {
                self.saves = FixturesDetailsItemModel(parametersJson: saves)
            }
            if let goals = parametersJson["goals"]?.dictionaryValue
            {
                self.goals = FixturesDetailsItemModel(parametersJson: goals)
            }
            if let goalAssist = parametersJson["goalAssist"]?.dictionaryValue
            {
                self.goalAssist = FixturesDetailsItemModel(parametersJson: goalAssist)
            }
            if let yellowCard = parametersJson["yellowCard"]?.dictionaryValue
            {
                self.yellowCard = FixturesDetailsItemModel(parametersJson: yellowCard)
            }
            if let redCard = parametersJson["redCard"]?.dictionaryValue
            {
                self.redCard = FixturesDetailsItemModel(parametersJson: redCard)
            }
            if let bouns = parametersJson["bouns"]?.dictionaryValue
            {
                self.bouns = FixturesDetailsItemModel(parametersJson: bouns)
            }
    }
}
