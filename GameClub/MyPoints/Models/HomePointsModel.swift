//
//  HomePointsModel.swift
//  GameClub
//
//  Created by Basma on 7/9/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation
import SwiftyJSON

class HomePointsModel : NSObject{
    var total_user : Int?
    var total_sum : Int?
    var total_avg : Int?
    var heigh_point : Int?
    var user_total_sum : Int?
    override init() {
                 }
       init(parametersJson: [String: JSON])
                  {
                   if let total_user = parametersJson["total_user"]?.intValue
                   {
                       self.total_user = total_user
                   }
                    
                    if let total_sum = parametersJson["total_sum"]?.intValue
                    {
                        self.total_sum = total_sum
                    }
                    
                    if let total_avg = parametersJson["total_avg"]?.intValue
                    {
                        self.total_avg = total_avg
                    }
                    
                    if let heigh_point = parametersJson["heigh_point"]?.intValue
                    {
                        self.heigh_point = heigh_point
                    }
                    
                    if let user_total_sum = parametersJson["user_total_sum"]?.intValue
                    {
                        self.user_total_sum = user_total_sum
                    }
    }
}
