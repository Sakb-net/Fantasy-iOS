//
//  MyLeague.swift
//  GameClub
//
//  Created by Basma on 9/20/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation
import SwiftyJSON

class MyLeague : NSObject {
    var user_id : Int?
    var name : String?
    var code : String?
    var admin_id : [Any]?
    var image : String?
    var link : String?
    var num_allow_users : String?
    var eldwry_name : String?
    var eldwry_link : String?
    var num_week : String?
    var lang_num_week : String?
    var subeldwry_link : String?
    var current_sort : String?
    
    override init() {
        
    }
    
    init(parametersJson: [String: JSON])
    {
        if let user_id = parametersJson["user_id"]?.intValue
        {
            self.user_id = user_id
        }
        
        if let current_sort = parametersJson["current_sort"]?.stringValue
        {
            self.current_sort = current_sort
        }
        
        if let name = parametersJson["name"]?.stringValue
        {
            self.name = name
        }
        
        if let code = parametersJson["code"]?.stringValue
        {
            self.code = code
        }
        
        if let link = parametersJson["link"]?.stringValue
        {
            self.link = link
        }
        
        if let admin_id = parametersJson["admin_id"]?.arrayObject
        {
            self.admin_id = admin_id
        }
        
        if let image = parametersJson["image"]?.stringValue
        {
            self.image = image
        }
        
        if let num_allow_users = parametersJson["num_allow_users"]?.stringValue
        {
            self.num_allow_users = num_allow_users
        }
        
        if let eldwry_name = parametersJson["eldwry_name"]?.stringValue
        {
            self.eldwry_name = eldwry_name
        }
        
        if let eldwry_link = parametersJson["eldwry_link"]?.stringValue
        {
            self.eldwry_link = eldwry_link
        }
        
        if let num_week = parametersJson["num_week"]?.stringValue
        {
            self.num_week = num_week
        }
        
        if let lang_num_week = parametersJson["lang_num_week"]?.stringValue
        {
            self.lang_num_week = lang_num_week
        }
        
        if let subeldwry_link = parametersJson["subeldwry_link"]?.stringValue
        {
            self.subeldwry_link = subeldwry_link
        }
    }
}

