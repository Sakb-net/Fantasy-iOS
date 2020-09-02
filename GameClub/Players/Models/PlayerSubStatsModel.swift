//
//  PlayerSubStatsModel.swift
//  GameClub
//
//  Created by Basma on 7/25/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation
import SwiftyJSON
class PlayerSubStatsModel : NSObject {
    var lang_point:String?
    var number:Int?
    var points:Int?

override init() {
       }

       init(parametersJson: [String: JSON])
       {
        
        if let lang_point = parametersJson["lang_point"]?.stringValue
        {
            self.lang_point = lang_point
        }
        
           if let number = parametersJson["number"]?.intValue
           {
               self.number = number
           }
           
           if let points = parametersJson["points"]?.intValue
           {
               self.points = points
           }
           
}
}
