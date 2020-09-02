//
//  SubDaweryModel.swift
//  GameClub
//
//  Created by Basma on 8/6/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation
import SwiftyJSON

class SubDaweryModel : NSObject {
    var link : String?
    var name : String?
    var num_week : Int?
    var lang_num_week : String?
    var start_date : String?
    var start_date_day : String?
    var end_date : String?
    var end_date_day : String?
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
                
                if let start_date = parametersJson["start_date"]?.stringValue
                {
                    self.start_date = start_date
                }
                if let start_date_day = parametersJson["start_date_day"]?.stringValue
                {
                    self.start_date_day = start_date_day
                }
                if let end_date = parametersJson["end_date"]?.stringValue
                {
                    self.end_date = end_date
                }
                if let end_date_day = parametersJson["end_date_day"]?.stringValue
                {
                    self.end_date_day = end_date_day
                }
    }
}
