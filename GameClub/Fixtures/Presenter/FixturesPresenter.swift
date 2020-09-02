//
//  FixturesPresenter.swift
//  GameClub
//
//  Created by Basma on 8/6/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation
class FixturesPresenter {
    func getGWs(onSuccess: @escaping ([SubDaweryModel]) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().get_subeldwry()
        
        ServiceManager.callAPI(url: url, method: .get, parameters: nil, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 0 {
                    if let data = response!["data"].array {
                        var subDaweryModels = [SubDaweryModel]()
                        
                        for subDaweryItem in data {
                            subDaweryModels.append(SubDaweryModel(parametersJson: subDaweryItem.dictionaryValue))
                        }
                        onSuccess(subDaweryModels)
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
                onFailure(error?.localizedDescription)
            }
        }
    }
    
    func getGWFixtures(link : String, onSuccess: @escaping ([Fixtures]) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().get_subeldwry(link: link)
        
        ServiceManager.callAPI(url: url, method: .get, parameters: nil, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 0 {
                    if let data = response!["data"].array {
                        var fixtures = [Fixtures]()
                        
                        for fixtureItem in data {
                            fixtures.append(Fixtures(parametersJson: fixtureItem.dictionaryValue))
                            
                        }
                        onSuccess(fixtures)
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
                onFailure(error?.localizedDescription)
            }
        }
    }
}
