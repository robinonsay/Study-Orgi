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
    //only sets it to null
    static func rmvMember2(groupObjectID: String, memberObjectID: String) {
        let group = PFQuery(className: "Groups").getObjectWithId(groupObjectID) as PFObject!
        let member = PFQuery(className: "Members").getObjectWithId(memberObjectID) as PFObject!
        //member["Group"] = nil
        member.setObject(NSNull(), forKey: "Group")
        member?.save()
        
        
    }
    
    static func bestDate(){
        
    }
    static func pickBestDay(group:String, startDate:NSDate, endDate:NSDate){
        
    }
    static func rmvMember(groupID:String , userID:String){
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