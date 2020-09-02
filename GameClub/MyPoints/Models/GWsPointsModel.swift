//
//  GWsPointsModel.swift
//  GameClub
//
//  Created by Basma on 7/9/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation
import SwiftyJSON

class GWsPointsModel : NSObject {
    var link : String?
    var name : String?
    var num_week : Int?
    var lang_num_week : String?
    var cost : Int?
    var start_date : String?
    var end_date : String?
    var created_at : String?
    var final_point : Int?
    var avg_point : Int?
    var heigh_point : Int?
    var sort_gwla : Int?
    var transfer : Int?
    override init() {
              }
    init(parametersJson: [String: JSON])
               {
                if let link = parametersJson["link"]?.stringValue
                {
                    self.link = link
                }
                if let name = parametersJson["name"]?.stringValue
                {
                    self.name = name
                }
                if let num_week = parametersJson["num_week"]?.intValue
                {
                    self.num_week = num_week
                }
                if let lang_num_week = parametersJson["lang_num_week"]?.stringValue
                {
                    self.lang_num_week = lang_num_week
                }
                
                if let cost = parametersJson["cost"]?.intValue
                {
                    self.cost = cost
                }
                if let start_date = parametersJson["start_date"]?.stringValue
                {
                    self.start_date = start_date
                }
                if let end_date = parametersJson["end_date"]?.stringValue
                {
                    self.end_date = end_date
                }
                   if let created_at = parametersJson["created_at"]?.stringValue
                   {
                       self.created_at = created_at
                   }
                
                if let final_point = parametersJson["final_point"]?.intValue
                {
                    self.final_point = final_point
                }
                
                if let avg_point = parametersJson["avg_point"]?.intValue
                {
                    self.avg_point = avg_point
                }
                
                if let heigh_point = parametersJson["heigh_point"]?.intValue
                {
                    self.heigh_point = heigh_point
                }
                
                if let sort_gwla = parametersJson["sort_gwla"]?.intValue
                {
                    self.sort_gwla = sort_gwla
                }
                
                if let transfer = parametersJson["transfer"]?.intValue
                {
                    self.transfer = transfer
                }
        }
}