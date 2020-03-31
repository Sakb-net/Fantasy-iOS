//
//  Lineup.swift
//  GameClub
//
//  Created by Basma on 3/31/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation
import SwiftyJSON

class Lineup: NSObject{
        var value : Int?
        
        override init() {
        }
        
        init(parametersJson: [String: JSON])
        {
            
            if let value = parametersJson["value"]?.intValue
            {
                self.value = value
            }
            
        }
    }
