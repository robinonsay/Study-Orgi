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
        let userPointer = PFObject(withoutDataWithClassName:"_User", objectId: userID)
        let groupPointer = PFObject(withoutDataWithClassName: "Groups", objectId: groupID)
        var members = PFObject(className: "Members")
        members.setObject(userPointer, forKey: "Member")
        members.setObject(groupPointer, forKey: "Group")
        members.saveInBackground()
    }
    
    static func mkGroup(title:String, description:String, isPublic:Bool,
        creatorID:String, startDate:NSDate, endDate:NSDate){
            print("add")
            let userPointer = PFObject(withoutDataWithClassName:"_User", objectId: creatorID)
            let group = PFObject(className: "Group")
                
            //Assign the properties of the group to the PFObject
            group.setObject(title, forKey: "Title")
            group.setObject(description, forKey: "Description")
            group.setObject(isPublic, forKey: "Public")
            group.setObject(userPointer, forKey: "Creator")
            group.setObject(startDate, forKey: "Start")
            group.setObject(endDate, forKey: "End")
            group.addObject(userPointer, forKey: "members")
    
            //Push that PFObject onto the database
            group.saveInBackground()
    }
    static func removeMember(groupID:String , userID:String){
        var member = PFQuery(className:"Members")
        
        member.whereKey("Member", equalTo: PFObject(withoutDataWithClassName:"_User", objectId: userID))
        
        var group = PFQuery(className:"Members")
        group.whereKey("Group", equalTo: PFObject(withoutDataWithClassName: "Groups", objectId: groupID))
        
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