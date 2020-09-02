//
//  GeneralMatchData.swift
//  GameClub
//
//  Created by Basma on 8/29/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation
import SwiftyJSON

class GeneralMatchData : NSObject {
       var first_goon:Int?
       var second_goon:Int?
    
    override init() {
    }

    init(parametersJson: [String: JSON])
    {
     
     if let first_goon = parametersJson["first_goon"]?.intValue
     {
         self.first_goon = first_goon
     }
        
        if let second_goon = parametersJson["second_goon"]?.intValue
        {
            self.second_goon = second_goon
        }
    }
}
