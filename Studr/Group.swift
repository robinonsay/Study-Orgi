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
    
    func getGroup(groupID : String) -> PFObject{
        var group = PFObject(className: "Groups")
        var query = PFQuery(className:"Groups")
        query.getObjectInBackgroundWithId(groupID) {
            (group: PFObject?, error: NSError?) -> Void in
            if error != nil {
                println(error)
            } else if let group = group {
            }
        }
        return group
    }
    
    func getMembers(groupID : String) -> [PFObject]{
        var group = getGroup(groupID)
        return group["Members"] as! [(PFObject)]
    }
    
    
    func addMember(groupID: String, userID : String){
        var members = getMembers(groupID)
        members.append(PFObject(withoutDataWithClassName:"Users", objectId: userID))
        
        var group = getGroup(groupID)
        group.setObject(members, forKey: "Members")
        
    }
}