//
//  Group.swift
//  Studr
//
//  Created by Robin Onsay on 9/12/15.
//  Copyright (c) 2015 JJR. All rights reserved.
//

import Foundation
import Parse
class Database {
    static let USER = "_User"
    static func addMember(userObjectID:String, toGroup groupObjectID:String){
        var query = PFQuery(className:"Group")
        query.whereKey("objectId", equalTo: groupObjectID)
        query.findObjectsInBackgroundWithBlock {
            (results: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                // results contains Member in group
                for group in results as! [PFObject]{
                    let userPointer = PFObject(withoutDataWithClassName:self.USER, objectId: userObjectID)
                    group.addObject(userPointer, forKey: "members")
                    group.saveInBackground()
                }
            }
        }
    }
    
    static func mkGroup(title:String, description:String, isPublic:Bool,
        creatorID:String, startDate:NSDate, endDate:NSDate){
            print("add")
            let userPointer = PFObject(withoutDataWithClassName:USER, objectId: creatorID)
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
    static func removeMember(userObjectID:String, fromGroup groupObjectID:String){
        var query = PFQuery(className:"Group")
        query.whereKey("objectId", equalTo: groupObjectID)
        query.findObjectsInBackgroundWithBlock {
            (results: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                // results contains Member in group
                for group in results as! [PFObject]{
                    let userPointer = PFObject(withoutDataWithClassName:self.USER, objectId: userObjectID)
                    group.removeObject(userPointer, forKey: "members")
                    group.saveInBackground()
                }
            }
        }
    }
    
    static func requestFriend(userObjectID:String){
        var query = PFQuery(className:self.USER)
        query.getObjectInBackgroundWithId(userObjectID) {
            (user: PFObject?, error: NSError?) -> Void in
            if error == nil && user != nil {
                let currentUserPointer = PFObject(withoutDataWithClassName: self.USER, objectId: PFUser.currentUser()?.objectId)
                //user?.addObject(currentUserPointer, forKey: "pendingFriends")
                user?.addUniqueObject(currentUserPointer, forKey: "pendingFriends")
                user?.saveInBackground()
            } else {
                println(error)
            }
        }
    }
    
    static func acceptFriend(userObjectID:String){
        var myID = PFUser.currentUser()?.objectId
        println(myID)
        
        var query = PFQuery(className:USER)
        query.getObjectInBackgroundWithId(myID!) {
            (user: PFObject?, error: NSError?) -> Void in
            if error == nil && user != nil {
                if (user?.valueForKey("pendingFriends")?.containsObject(PFObject(withoutDataWithClassName: "User", objectId: userObjectID)) != nil) {
                    user?.removeObject(PFObject(withoutDataWithClassName: "User", objectId: userObjectID), forKey: "pendingFriends")
                    user?.addObject(PFObject(withoutDataWithClassName: "User", objectId: userObjectID), forKey: "friends")
                }
            } else {
                println(error)
            }
        }
        
    }
}