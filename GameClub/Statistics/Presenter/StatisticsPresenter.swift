//
//  StatisticsPresenter.swift
//  GameClub
//
//  Created by Basma on 8/28/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation

class StatisticsPresenter {
    func getStatistics(teamLink:String, order_play:String, loc_player:String, onSuccess: @escaping ([StatisticsModel]) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getStatistics()
        
        let parameters:[String:Any] = [
            "lang": HelperMethods.getCurrentLanguage(),
            "link_team" : teamLink,
            "order_play" : order_play,
            "loc_player" : loc_player
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 0 {
                    if let data = response!["data"]["all_data"].array {
                        var statisticsList = [StatisticsModel]()
                        for list in data {
                            statisticsList.append(StatisticsModel(parametersJson: list.dictionaryValue))
                        }
                        onSuccess(statisticsList)
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
}
