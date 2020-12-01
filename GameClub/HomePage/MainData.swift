//
//  MainData.swift
//  GameClub
//
//  Created by Basma on 7/18/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation
import SwiftyJSON
//"link": "458243f913a9bcde3560abea564528c2ecf1",
//"num_week": 34,
//"name": "2020-06-27Z",
//"cost": null,
//"start_date": "2020-12-26 23:00:00",
//"end_date": "2020-12-26 23:00:00",
//"created_at": "2020-06-09"
class MainData : NSObject {
    var link : String?
    var num_week : Int?
    var name : String?
    var change_point : Int?
    var start_date : String?
    var end_date : String?
    var created_at : String?
    override init() {
    }
    
    init(parametersJson: [String: JSON])
    {
        if let link = parametersJson["link"]?.stringValue
        {
            self.link = link
        }
        
        if let num_week = parametersJson["num_week"]?.intValue
        {
            self.num_week = num_week
        }
        
        if let name = parametersJson["name"]?.stringValue
        {
            self.name = name
        }
        
        if let change_point = parametersJson["change_point"]?.intValue
        {
            self.change_point = change_point
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
    }
}
