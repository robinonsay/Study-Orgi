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
    
    static func setAvailability(userAvailability:[[NSDate:Int]]){
        var userAva = PFObject(className: "UserAvailability")
        var myID = PFUser.currentUser()?.objectId
        userAva.setObject(PFObject(withoutDataWithClassName: "_User", objectId: myID), forKey: "User")
        userAva.setObject(userAvailability, forKey: "Availability")
        userAva.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
                println("Success")
            } else {
                // There was a problem, check error.description
                
                println(error)
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
            var request = PFObject(className: "FriendRequests")
            var myID = PFUser.currentUser()?.objectId
            request.setObject(PFObject(withoutDataWithClassName: "_User", objectId: myID), forKey: "Sender")
            request.setObject(PFObject(withoutDataWithClassName: "_User", objectId: userObjectID), forKey: "Receiver")
            request.setObject(false, forKey: "Accepted")
            request.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                if (success) {
                    // The object has been saved.
                    println("Success")
                } else {
                    // There was a problem, check error.description
                    
                    println(error)
                }
        }
    }
    static func acceptFriend(userObjectID:String){
        var quereyRec = PFQuery(className: "FriendRequests")
        quereyRec.whereKey("Receiver", equalTo: PFObject(withoutDataWithClassName: "_User", objectId:PFUser.currentUser()!.objectId!))
        var quereySender = PFQuery(className: "FriendRequests")
        quereySender.whereKey("Sender", equalTo: PFObject(withoutDataWithClassName: "_User", objectId: userObjectID))
        
        var querey = PFQuery.orQueryWithSubqueries([quereyRec,quereySender])
        querey.findObjectsInBackgroundWithBlock { (results:[AnyObject]?, error:NSError?) -> Void in
            if error == nil{
                for obj in results as![PFObject]{
                    obj.setObject(true, forKey: "Accepted" )
                    obj.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
                        if (success) {
                            // The object has been saved.
                            println("Success")
                        } else {
                            // There was a problem, check error.description
                            
                            println(error)
                        }
                    })
                    
                }
            }
        }
        
        
    }
}