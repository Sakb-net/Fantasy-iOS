//
//  LeagueSettingsAPIservice.swift
//  GameClub
//
//  Created by Basma on 10/1/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation
class LeagueSettingsAPIservice {
    func getLeagueDetails(link:String, leagueType: String, onSuccess: @escaping (MyLeagueDetails) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getLeagueDetails(link: link, type: leagueType)
        
        ServiceManager.callAPI(url: url, method: .get, parameters: nil, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 0 {
                    let data = response!["data"].dictionaryValue
                    let details = MyLeagueDetails(parametersJson: data)
                    onSuccess(details)
                    
                }else{
                    onFailure("Can't load league details, try again later!".localized)
                }
                  
            }
            else
            {
                onFailure(error!.localizedDescription)
            }
        }
    }
    
    func addAdminToLeague(link:String, leagueType : String, username : String, onSuccess: @escaping (Bool) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let parameters = [
            "user_name" : username
        ]
        let url = Urls().addAdminToLeague(link: link, type: leagueType)
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 0 {
                    let data = response!["data"].boolValue
                    onSuccess(data)
                    
                }else{
                    let message = response!["Message"].stringValue
                    onFailure(message)
                }
            }
            else
            {
                onFailure("Something went wrong try again later!".localized)
            }
        }
    }
    
    func deletePlayerFromLeague(link:String, leagueType : String, username : String, onSuccess: @escaping (Bool) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let parameters = [
            "user_name" : username
        ]
        let url = Urls().deletePlayerFromLeague(link: link, type: leagueType)
        
        ServiceManager.callAPI(url: url, method: .delete, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 0 {
                    let data = response!["data"]["update"].boolValue
                    onSuccess(data)
                    
                }else{
                    let message = response!["Message"].stringValue
                    onFailure(message)
                }
            }
            else
            {
                onFailure("Something went wrong try again later!".localized)
            }
        }
    }
    
    func updateLeagueInfo(link:String, leagueType: String, link_subeldwry: String, name : String, onSuccess: @escaping (Bool) -> Void, onFailure: @escaping (Bool) -> Void ) -> Void
    {
        let parameters = [
            "name" : name,
            "link_subeldwry" : link_subeldwry
        ]
        let url = Urls().updateLeague(link: link, type: leagueType)
        
        ServiceManager.callAPI(url: url, method: .put, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["data"]["status"].intValue
                if statusCode != 0 {
                    onSuccess(true)
                }else{
//                    let message = response!["Message"].stringValue
                    onFailure(false)
                }
            }
            else
            {
                onFailure(false)
            }
        }
    }
    
    func DeleteLeague(link:String, leagueType : String, onSuccess: @escaping (Bool) -> Void, onFailure: @escaping (Bool) -> Void ) -> Void
        {
            let url = Urls().DeleteLeague(link: link, type: leagueType)
            
            ServiceManager.callAPI(url: url, method: .put, parameters: nil, custumHeaders: nil) { (error, response) in
                
                if response != nil
                {
                    let statusCode = response!["StatusCode"].intValue
                    if statusCode == 0 {
                        let data = response!["data"].boolValue
                        onSuccess(data)
                        
                    }else{
                        onFailure(false)
                    }
                }
                else
                {
                    onFailure(false)
                }
            }
        }
}
