//
//  PointsPresenter.swift
//  GameClub
//
//  Created by Basma on 7/4/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation

class PointsPresenter {
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
}
