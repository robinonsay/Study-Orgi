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
    
    static func addMember(groupID:String , userID:String){
        var members = PFObject(className: "Members")
        let userPointer = PFObject(withoutDataWithClassName:"_User", objectId: userID)
        let groupPointer = PFObject(withoutDataWithClassName: "Groups", objectId: groupID)
        members.setObject(userPointer, forKey: "Member")
        
        members.setObject(groupPointer, forKey: "Group")
        
        members.saveInBackground()
    }
    
    static func rmvMember(groupID:String , userID:String){
        var member = PFQuery(className:"Members")
        let userPointer = PFObject(withoutDataWithClassName:"_User", objectId: userID)
        let groupPointer = PFObject(withoutDataWithClassName: "Groups", objectId: groupID)
        member.whereKey("Member", equalTo: userPointer)
        
        var group = PFQuery(className:"Members")
        group.whereKey("Group", equalTo: groupPointer)
        
        var query = PFQuery.orQueryWithSubqueries([member, group])
        query.findObjectsInBackgroundWithBlock {
            (results: [AnyObject]?, error: NSError?) -> Void in
            if error != nil {
                // results contains Member in group
                for objects in results as! [PFObject]{
                    objects.deleteInBackground()
                    objects.saveInBackground()
                }
                
            }
            
        }
    }
}