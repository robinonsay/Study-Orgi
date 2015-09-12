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
    
    func getMembers(groupID : String) -> [PFObject]{
        var members = [PFObject]()
        var query = PFQuery(className:"Groups")
        query.getObjectInBackgroundWithId(groupID) {
            (group: PFObject?, error: NSError?) -> Void in
            if error != nil {
                println(error)
            } else if let group = group {
                members = group["Members"] as! [(PFObject)]
            }
        }
        return members
    }
}