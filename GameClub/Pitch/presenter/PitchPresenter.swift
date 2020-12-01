//
//  PitchPresenter.swift
//  GameClub
//
//  Created by Basma on 9/8/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation
class PitchPresenter {
    
    
    
    func resetBTs () {
                UserDefaults.standard.set(0, forKey: "bt1")
                UserDefaults.standard.set(0, forKey: "bt2")
                UserDefaults.standard.set(0, forKey: "bt3")
                UserDefaults.standard.set(0, forKey: "bt4")
                UserDefaults.standard.set(0, forKey: "bt5")
                UserDefaults.standard.set(0, forKey: "bt6")
                UserDefaults.standard.set(0, forKey: "bt7")
                UserDefaults.standard.set(0, forKey: "bt8")
                UserDefaults.standard.set(0, forKey: "bt9")
                UserDefaults.standard.set(0, forKey: "bt10")
                UserDefaults.standard.set(0, forKey: "bt11")
                UserDefaults.standard.set(0, forKey: "bt12")
                UserDefaults.standard.set(0, forKey: "bt13")
                UserDefaults.standard.set(0, forKey: "bt14")
                UserDefaults.standard.set(0, forKey: "bt15")
    }
    
    
    func getSubstitutions (oldPlayers: [[MyTeam]], newPlayers: [[MyTeam]]) -> [[MyTeam]]{
        var allSubs = [[MyTeam]]()
        for n in 0...(oldPlayers.count-1){
            let oldPlayerArray = oldPlayers[n]
            let newPlayerArray = newPlayers[n]
            for i in 0...(oldPlayerArray.count-1){
                let oldLink = oldPlayerArray[i].link_player
                let newLink = newPlayerArray[i].link_player
                if oldLink != newLink {
                    allSubs.append([oldPlayerArray[i], newPlayerArray[i]])
                }
            }
        }
        return allSubs
    }
    func createSubString (allSubs : [[MyTeam]]) -> String{
        var subsArray = String()
        for n in 0...allSubs.count-1{
            let player_id1 = allSubs[n][0].player_id ?? 0
            let player_id2 = allSubs[n][1].player_id ?? 0
            let player_cost = allSubs[n][1].cost_player ?? 0
            print(player_id1)
            subsArray += #"{"newplayer_id":"\#(player_id2)","substituteplayer_id":"\#(player_id1)""#
            subsArray += #","substituteplayer_cost":"\#(player_cost)"}"#
            if n != allSubs.count-1 {
                subsArray += ","
            }else {
                subsArray = "[\(subsArray)]"
            }
        }
        return subsArray
    }
    
    func getGSCardState(cardType: String, onSuccess: @escaping (GSCardsStateModel) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getGSCardState(type: cardType)
       
        ServiceManager.callAPI(url: url, method: .get, parameters: nil, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let data = response!["data"].dictionaryValue
                let generalData = GSCardsStateModel(parametersJson: data)
                    onSuccess(generalData)
                
                }else{
                    onFailure("Something went wrong try again later!".localized)
                }
        }
    }
    
    func goldCardPayment(array_players: String, onSuccess: @escaping (String, String) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().goldCardPayment()
        let parameters = ["array_players" : array_players]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let checkoutId = response!["data"]["checkoutId"].stringValue
                let shopperResultUrl = response!["data"]["shopperResultUrl"].stringValue
                
                onSuccess(checkoutId, shopperResultUrl)
                
            }else{
                onFailure("Something went wrong try again later!".localized)
            }
        }
       }
    
    func confirmPayment(checkout_id:String, resourcePath : String, onSuccess: @escaping (String) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        
        let url = Urls().goldCardConfirmPayment()
        
        let parameters:[String:Any] = [
            "checkout_id": checkout_id,
            "resourcePath": resourcePath
        ]
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 0 {
                    let message = response!["data"]["mesage_pay"].stringValue
                    onSuccess(message)
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
