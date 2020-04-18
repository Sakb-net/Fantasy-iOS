//
//  InstructionModel.swift
//  GameClub
//
//  Created by Basma on 4/16/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation
import SwiftyJSON
class InstructionModel : NSObject {
    var title : String?
    var content : String?
    
    override init() {
    }
    
    init(parametersJson: [String: JSON])
    {
        if let title = parametersJson["title"]?.stringValue
        {
            self.title = title
        }
        
        if let content = parametersJson["content"]?.stringValue
        {
            self.content = content
        }
    }
}
