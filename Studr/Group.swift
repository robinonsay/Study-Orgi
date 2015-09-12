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
    static func mkGroup(title:String, description:String, ppublic:Bool,
        creatorID:String, startDate:NSDate, endDate:NSDate){
            //Group is creator
            let userPointer = PFObject(withoutDataWithClassName:"_User", objectId: creatorID)
            let group = PFObject(className: "Group")
            group.setObject(title, forKey: "Title")
            group.setObject(description, forKey: "Description")
            group.setObject(ppublic, forKey: "Public")
            group.setObject(userPointer, forKey: "Creator")
            group.setObject(startDate, forKey: "Start")
            group.setObject(endDate, forKey: "End")
            if !isTitleTaken(creatorID, title: title){
                group.saveInBackground()
                getGroupId(creatorID, title: title)
                
            }
            
            
            
            
    }
    
    static func getGroupId(creatorId:String, title:String)->String{
        var creator = PFQuery(className: "Groups")
        
        creator.whereKey("Creator", equalTo: PFObject(withoutDataWithClassName: "_User", objectId: creatorId))
        
        var titles = PFQuery(className: "Groups")
        
        titles.whereKey("Title", equalTo: title)
        var query = PFQuery.orQueryWithSubqueries([creator, titles])
        var id:String
        query.findObjectsInBackgroundWithBlock { (results: [AnyObject]?, error: NSError?) -> Void in
            let obj:PFObject = results[0] as! PFObject
            
            id = obj.objectId!
            println(id)
        }
    }
   
    static func isTitleTaken(creatorID:String, title:String)->Bool{
        var isTaken = true
        var creator = PFQuery(className: "Groups")
        
        creator.whereKey("Creator", equalTo: PFObject(withoutDataWithClassName: "_User", objectId: creatorID))
        
        var titles = PFQuery(className: "Groups")
        
        titles.whereKey("Title", equalTo: title)
        var id:PFObject!
        var query = PFQuery.orQueryWithSubqueries([creator, titles])
        query.findObjectsInBackgroundWithBlock {
            (results: [AnyObject]?, error: NSError?) -> Void in
            if error == nil && results == nil {
                // results contains Member in group
               isTaken = false
                
                
            }
        }
        return isTaken
        
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