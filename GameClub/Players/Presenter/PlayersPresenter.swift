//
//  PlayersPresenter.swift
//  GameClub
//
//  Created by Basma on 3/8/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation

class PlayersPresenter {
    func getPlayers(type:String, teamLink:String,word_search:String, order_play:String,from_price:String, to_price:String,loc_player:String, onSuccess: @escaping ([Player]) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getPlayerFilter()
        
        let parameters:[String:Any] = [
            "lang": HelperMethods.getCurrentLanguage(),
            "type_key": type,
            "link_team" : teamLink,
            "word_search" : word_search,
            "order_play" : order_play,
            "from_price" : from_price,
            "to_price" : to_price,
            "loc_player" : loc_player
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 0 {
                    if let data = response!["data"][0]["players_group"].array {
                        var playersList = [Player]()
                        for player in data {
                            playersList.append(Player(parametersJson: player.dictionaryValue))
                        }
                        onSuccess(playersList)
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
    
    func getFilterPlayers(type:String, onSuccess: @escaping ([Player]) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getPlayersByType()
        
        let parameters:[String:Any] = [
            "lang": HelperMethods.getCurrentLanguage(),
            "type_key": type
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 0 {
                    if let data = response!["data"][0]["players_group"].array {
                        var playersList = [Player]()
                        for player in data {
                            playersList.append(Player(parametersJson: player.dictionaryValue))
                        }
                        onSuccess(playersList)
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
    
    func addPlayer(link:String, onSuccess: @escaping (AddedPlayerDetails) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().addPlayer()
        
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
                    var playersDetails = AddedPlayerDetails()
                    playersDetails = AddedPlayerDetails(parametersJson: data)
                    onSuccess(playersDetails)
                    
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
    
    func deletePlayer(player_link:String, eldwry_link:String, onSuccess: @escaping (String) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().deletePlayer()
        
        let parameters:[String:Any] = [
            "lang": HelperMethods.getCurrentLanguage(),
            "eldwry_link": eldwry_link,
            "player_link": player_link
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 0 {
                let data = response!["data"].dictionaryValue
                    let message = data["msg_delete"]?.stringValue
                    
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
    
    func replacePlayer(deleted_player_link:String, player_link:String, eldwry_link:String, onSuccess: @escaping (String) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().replacePlayer()
        
        let parameters:[String:Any] = [
            "lang": HelperMethods.getCurrentLanguage(),
            "eldwry_link": eldwry_link,
            "delet_player_link": deleted_player_link,
            "add_player_link": player_link
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let message = response!["Message"].stringValue
                
                        onSuccess(message)
                    
                }else{
                    let message = response!["message"].stringValue
                    onFailure(message)
                }
            
        }
    }
  
    func getMyTeam(type : Int, onSuccess: @escaping ([MyTeam], [MyTeam], [MyTeam], [MyTeam], Int, Double, Int) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        var url = ""
        if type == 0 {
         url = Urls().getMyTeam()
    }else {
         url = Urls().auto_selection_player()
    }
        
        let parameters:[String:Any] = [
            "lang": HelperMethods.getCurrentLanguage()        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 0 {
                    
                    let numPlayer = response!["total_team_play"].intValue
                    let costPlayers = response!["remide_sum_cost"].doubleValue
                    let remainGold = response!["pay_total_cost"].doubleValue
                    let totalGold = response!["total_cost_play"].intValue

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
                        onSuccess(goalKeepers, defenders, mids, attackers, numPlayer, remainGold, totalGold)
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
    
    func resetAllPlayers(onSuccess: @escaping (String) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().reset_all_player()
       
        ServiceManager.callAPI(url: url, method: .post, parameters: nil, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let message = response!["Message"].stringValue
                
                        onSuccess(message)
                    
                }else{
                    let message = response!["message"].stringValue
                    onFailure(message)
                }
            
        }
    }

}
