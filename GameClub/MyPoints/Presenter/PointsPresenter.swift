//
//  PointsPresenter.swift
//  GameClub
//
//  Created by Basma on 7/4/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation

class PointsPresenter {
    
    func getHomePoints(onSuccess: @escaping (HomePointsModel, MainData) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getHomePoints()
       
        ServiceManager.callAPI(url: url, method: .get, parameters: nil, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let home_points = response!["home_points"].dictionaryValue
                let data = response!["data"].dictionaryValue

                var homePointsModel = HomePointsModel()
                var mainData = MainData()
                homePointsModel = HomePointsModel(parametersJson: home_points)
                mainData = MainData(parametersJson: data)
                onSuccess(homePointsModel, mainData)
                }else{
                    let message = response!["Message"].stringValue
                    onFailure(message)
                }
        }
    }
    
    func getPublicPoints(onSuccess: @escaping (PublicPoints) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let langString = "lang".localized
        let parameters:[String:Any] = [
            "lang": langString
        ]
        let url = Urls().getPublicPoints()
       
        ServiceManager.callAPI(url: url, method: .get, parameters: nil, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let data = response!["data"].dictionaryValue
                    var publicPoints = PublicPoints()
                    publicPoints = PublicPoints(parametersJson: data)
                    onSuccess(publicPoints)
                    
                }else{
                    let message = response!["Message"].stringValue
                    onFailure(message)
                }
            
        }
    }
    
    func getPointsGWs(onSuccess: @escaping ([GWsPointsModel]) -> Void, onFailure: @escaping (String?, Int) -> Void ) -> Void
    {
        let url = Urls().getPointsGW()
       
        ServiceManager.callAPI(url: url, method: .get, parameters: nil, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue

                if let data = response!["data"].array{
                    var gwsPointsModels = [GWsPointsModel]()
                for item in data {
                    gwsPointsModels.append(GWsPointsModel(parametersJson: item.dictionaryValue))

                }
                    onSuccess(gwsPointsModels)
                }else{
                    let message = response!["Message"].stringValue
                    onFailure(message, statusCode)
                }
                }else{
                    onFailure(error!.localizedDescription, 1000)

                }
            
        }
    }
    
    func getPoints(link : String, onSuccess: @escaping (GWsPointsModel, [MyTeam], [MyTeam], [MyTeam], [MyTeam],[MyTeam],[Int]) -> Void, onFailure: @escaping (String?, Int) -> Void ) -> Void
    {
        let url = Urls().getPoints()
       let parameters:[String:Any] = [
           "subeldwry_link": link
       ]
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
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
                                onFailure("Oops, Error occured",statusCode)
                            }
                            var gwsPointsModels = GWsPointsModel()

                            let data = response!["data"].dictionaryValue
                            gwsPointsModels = GWsPointsModel(parametersJson: data)
                            
                            if let data = response!["player_master"].array {
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
                                onSuccess(gwsPointsModels, goalKeepers, defenders, mids, attackers, subs, plan)
                            }else{
                                onFailure("Oops, Error occured",statusCode)}
                        }else{
                            let message = response!["Message"].stringValue
                            onFailure(message,statusCode)
                        }
                    }
                    else
                    {
                        onFailure(error!.localizedDescription, 1000)
                    }
            
        }
    }
}
}
