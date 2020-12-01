//
//  InstructionsPresenter.swift
//  GameClub
//
//  Created by Basma on 4/16/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation
class InstructionsPresenter {
    func getInstructions(onSuccess: @escaping ([InstructionModel], [InstructionModel]) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
       {
           let url = Urls().getInstructions()
           
           let parameters:[String:Any] = [
               "lang": HelperMethods.getCurrentLanguage()
           ]
           
           ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
               
               if response != nil
               {
                   let statusCode = response!["StatusCode"].intValue
                   if statusCode == 0 {
                    var content_role = [InstructionModel] ()
                    var content_help = [InstructionModel] ()

                    if let data = response!["data"]["content_role"].array{
                       for item in data {
                           content_role.append(InstructionModel(parametersJson: item.dictionaryValue))
                       }
                   }else{
                       let message = response!["Message"].stringValue
                       onFailure(message)
                   }
                    if let data = response!["data"]["content_help"].array{
                        for item in data {
                            content_help.append(InstructionModel(parametersJson: item.dictionaryValue))
                        }
                    }else{
                        let message = response!["Message"].stringValue
                        onFailure(message)
                    }
                    onSuccess(content_role, content_help)
                }
                   }
               else
               {
                   onFailure("Something went wrong try again later!".localized)
               }
           }
       }
}
