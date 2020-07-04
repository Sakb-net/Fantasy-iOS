//
//  PrizeCatModel.swift
//  GameClub
//
//  Created by Basma on 6/19/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation
import SwiftyJSON

class PrizeCatModel : NSObject {
    var title : String?
    var content : [String]?
    
    override init() {
    }
    
    init(parametersJson: [String: JSON])
    {
        
        if let title = parametersJson["title"]?.stringValue
        {
            self.title = title
        }
        
        if let content = parametersJson["content"]?.arrayValue
        {
            var items = [String]()
            for item in content {
                items.append(item.stringValue)
            }
            self.content = items
        }
        
    }
}
