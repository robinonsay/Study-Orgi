//
//  Group.swift
//  Studr
//
//  Created by Robin Onsay on 9/12/15.
//  Copyright (c) 2015 JJR. All rights reserved.
//

import Foundation
import Parse
class Group {
    let CLASS_NAME = "Groups"
    func bestDate(groupID : String){
        var query = PFQuery(className: CLASS_NAME)
        query.getObjectInBackgroundWithId(groupID) {
            (group: PFObject?, error: NSError?) -> Void in
            if error == nil && group != nil {
                println(group)
                var members = group?.objectForKey("Memebers")
                println(members)
                
            } else {
                println(error)
            }
        }
                
    }
    
    
}