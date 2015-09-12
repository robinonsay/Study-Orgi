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
    
    static func addMember(groupID:PFObject , userID:PFObject){
        var members = PFObject(className: "Members")
                members.setObject(userID, forKey: "Member")
        
        members.setObject(groupID, forKey: "Group")
        
        members.saveInBackground()
    }
    
    static func rmvMember2(groupObjectID: String, memberObjectID: String) {
        let group = PFQuery(className: "Groups").getObjectWithId(groupObjectID) as PFObject!
        let member = PFQuery(className: "Members").getObjectWithId(memberObjectID) as PFObject!
        //member["Group"] = nil
        member.setObject(NSNull(), forKey: "Group")
        member?.save()
    }
    
    static func rmvMember(groupID:PFObject , userID:PFObject){
        var member = PFQuery(className:"Members")
        
        member.whereKey("Member", equalTo: userID)
        
        var group = PFQuery(className:"Members")
        group.whereKey("Group", equalTo: groupID)
        
        var query = PFQuery.orQueryWithSubqueries([member, group])
        query.findObjectsInBackgroundWithBlock {
            (results: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                // results contains Member in group
                for objects in results as! [PFObject]{
                    objects.deleteInBackground()
//                    objects.saveInBackground()
                }
                
            }
            
        }
    }
}