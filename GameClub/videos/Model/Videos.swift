//
//  Videos.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/9/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit
import SwiftyJSON

class Videos: NSObject {

    var name:String?
    var link:String?
    var video:String?
    var image:String?
    var date:String?
    var created_at:String?
    var content:String?
    var upload_id:String?
    
    
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
        
        if let video = parametersJson["video"]?.stringValue
        {
            self.video = video
        }
        
        if let image = parametersJson["image"]?.stringValue
        {
            self.image = image
        }
        
        if let date = parametersJson["date"]?.stringValue
        {
            self.date = date
        }
        
        if let created_at = parametersJson["created_at"]?.stringValue
        {
            self.created_at = created_at
        }
        
        if let content = parametersJson["content"]?.stringValue
        {
            self.content = content
        }
        
        if let upload_id = parametersJson["upload_id"]?.stringValue
        {
            self.upload_id = upload_id
        }
    }
}
