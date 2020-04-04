//
//  MyTeamPresenter.swift
//  GameClub
//
//  Created by Basma on 3/31/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation

class MyTeamPresenter {
    func getMyTeam(onSuccess: @escaping ([MyTeam], [MyTeam], [MyTeam], [MyTeam],[MyTeam],[Int]) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getMySavedTeam()
        
        let parameters:[String:Any] = [
            "lang": HelperMethods.getCurrentLanguage()        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 0 {
                    var plan = [Int]()
                    if let lineup = response!["lineup"].array {
                        plan.append(lineup[0].intValue)
                        plan.append(lineup[1].intValue)
                        plan.append(lineup[2].intValue)
                    }else{
                        onFailure("Oops, Error occured")
                    }
                    if let data = response!["data"].array {
                        let goalKeepersJson = data[0].array
                        var goalKeepers = [MyTeam]()
                        for goalKeeper in goalKeepersJson! {
                            goalKeepers.append(MyTeam(parametersJson: goalKeeper.dictionaryValue))
                        }
                        
                        let defenderJson = data[1].array
                        var defenders = [MyTeam]()
                        for defender in defenderJson! {
                            defenders.append(MyTeam(parametersJson: defender.dictionaryValue))
                        }
                        
                        let midsJson = data[2].array
                        var mids = [MyTeam]()
                        for mid in midsJson! {
                            mids.append(MyTeam(parametersJson: mid.dictionaryValue))
                        }
                        
                        let attackersJson = data[3].array
                        var attackers = [MyTeam]()
                        for attacker in attackersJson! {
                            attackers.append(MyTeam(parametersJson: attacker.dictionaryValue))
                        }
                        
                        let subJson = data[4].array
                        var subs = [MyTeam]()
                        for sub in subJson! {
                            subs.append(MyTeam(parametersJson: sub.dictionaryValue))
                        }
                        onSuccess(goalKeepers, defenders, mids, attackers, subs, plan)
                    }else{
                        onFailure("Oops, Error occured")
                    }
                    
                }else{
                    let message = response!["Message"].stringValue
                    onFailure(message)
                }
            }
            else
            {
                onFailure(error!.localizedDescription)
            }
        }
    }
    
    func check_insideChange(link:String, onSuccess: @escaping (Check_insideChangeModel) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().check_insideChange()
        
        let parameters:[String:Any] = [
            "lang": HelperMethods.getCurrentLanguage(),
            "player_link": link
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 0 {
                let data = response!["data"].dictionaryValue
                    var checkInsideChange = Check_insideChangeModel()
                    checkInsideChange = Check_insideChangeModel(parametersJson: data)
                    onSuccess(checkInsideChange)
                    
                }else{
                    let message = response!["Message"].stringValue
                    onFailure(message)
                }
            }
            else
            {
                onFailure(error!.localizedDescription)
            }
        }
    }
    
    
    func addPlayer(playersIDs:[Int], onSuccess: @escaping (String) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().change_player()
        
        let parameters:[String:Any] = [
            "lang": HelperMethods.getCurrentLanguage(),
            "ch_game_player_id_one": playersIDs[0],
            "ch_player_id_one": playersIDs[1],
            "ch_game_player_id_two": playersIDs[2],
            "ch_player_id_two": playersIDs[3]
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 0 {
                let data = response!["data"].dictionaryValue
                    let message = data["msg_add"]?.stringValue
                    onSuccess(message!)
                    
                }else{
                    let message = response!["Message"].stringValue
                    onFailure(message)
                }
            }
            else
            {
                onFailure(error!.localizedDescription)
            }
        }
    }


}
 