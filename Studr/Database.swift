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
    static var userGroups = [Group]()
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
    
    static func setAvailability(userAvailability:[String:Int]){
        var userAva = PFObject(className: "UserAvailability")
        var myID = PFUser.currentUser()?.objectId
        userAva.setObject(PFObject(withoutDataWithClassName: "_User", objectId: myID), forKey: "User")
        userAva.addObject(userAvailability, forKey: "Availability")
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
    
    
    
    static func pickBestDate(groupID:String){
        var totals = [Int]()
        var dates = [String]()
        totals = [0,0,0,0,0,0,0]
        dates = ["","","","","","",""]
        var groupQuery = PFQuery(className: "Group")
        var membersInGroup:[PFObject]!
        
        
        //
        var group = groupQuery.getObjectWithId(groupID)
        
        membersInGroup = group?.objectForKey("members") as! [PFObject]
        
        for obj in membersInGroup{
            var id:String = obj.objectId!
            println(id)
            print(" THIS IS OBJ ID\n\n")
            var userQuery = PFQuery(className: "UserAvailability")
            userQuery.whereKey("User", equalTo: PFObject(withoutDataWithClassName: "_User", objectId: id))
            
            
            
            var objects = userQuery.findObjects() as! [PFObject]
            print("\n\n\n\n\n")
            print(objects.count)
            println()
            
            for object in objects {
                var avail:[[String:Int]] = object.objectForKey("Availability") as! [[String:Int]]
                
                for var i=0;i<7;++i{
                    for var j=0;j<avail.count;j++ {
                        totals[i] = totals[i] + Array(avail[j].values)[i]
                        dates[i] = Array(avail[j].keys)[i]
                    }
                }
            }
            
            var myDic:[String:Int] = [:]
            print(totals)
            print(dates)
            for var i=0;i<totals.count && i<dates.count;++i{
                myDic.updateValue(totals[i], forKey: dates[i])
            }
            
            print(myDic)
            
            group?.setObject(myDic, forKey: "totalAvail")
            group?.saveInBackgroundWithBlock({ (b: Bool, err: NSError?) -> Void in
                if b{
                    println("Success from total thing")
                }else {
                    println(err)
                }
            })
            
        }
        
        return totals
        
    }
    static func getAcceptedFriends()->[PFObject]{
        var friend = PFQuery(className: "FriendRequests")
        friend.whereKey("toUser", equalTo: PFObject(withoutDataWithClassName: "_User", objectId: PFUser.currentUser()?.objectId))
        var status = PFQuery(className: "FriendRequests")
        status.whereKey("status", equalTo: "accepted")

        var query = PFQuery.orQueryWithSubqueries([friend,status])
        query.findObjectsInBackgroundWithBlock {
            (result:[AnyObject]?, err:NSError?) -> Void in
            if err == nil{
                users = result as! [PFObject]
            }else{
                println(err)
            }
        }
        return users
    }
    
    
    static func getAllUsers()->[PFObject]{
        var users = [PFObject]()
        var query = PFQuery(className:"_User")
//        query.findObjectsInBackgroundWithBlock {
//            (objects: [AnyObject]?, error: NSError?) -> Void in
//            if error == nil{
//                users = objects as! [PFObject]
//            }else{
//                //Handle error
//                print(error)
//            }
//        }
        users = query.findObjects() as! [PFObject]
        print(users.count)
        return users
    }
    static func getAllFriends()->[String]{
        var accept = "accepted"
        var resultant = [String]()
        var query = PFQuery(className: "FriendRequests")
        query.whereKey("toUser", equalTo: PFObject(withoutDataWithClassName: "_User", objectId: PFUser.currentUser()?.objectId))
        query.findObjectsInBackgroundWithBlock { (result:[AnyObject]?, err:NSError?) -> Void in
            if err == nil{
                var res = result as! [PFObject]
                for var i=0 ;i < res.count;++i{
                    resultant[i] = res[i].objectForKey("status") as! String
                }
            }else{
                println(err)
            }
        }
        return resultant
    }
    static func mkGroup(title:String, description:String, isPublic:Bool,
        startDate:NSDate, endDate:NSDate, location:String)->String{
            var creatorID = PFUser.currentUser()?.objectId
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
            group.setObject(location, forKey: "Location")
            
            //Push that PFObject onto the database
            var myID = ""
            group.save()
            group.fetch()
            
            //            group.saveInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
            //                if success{
            //
            //                    group.fetchInBackgroundWithBlock { (obj:PFObject?, error:NSError?) -> Void in
            //                        if obj != nil && error == nil{
            //                            println(obj)
            //                            myID = obj!.objectId!
            //                            println("SUCESSSSSSSSS")
            //
            //                        }else{
            //                            print(error)
            //                            println(" ERRRORR in mkGroup")
            //                        }
            //                    }
            //                }else{
            //                    print(error)
            //                    println(" ERRRORin mkGroup")
            //                }
            //            }
            
            
            myID = group.objectId!
            print("REACHED STATMENT")
            println(group.objectId)
            return myID
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
        let fromUserPointer = PFObject(withoutDataWithClassName: "_User", objectId: myID)
        let toUserPointer = PFObject(withoutDataWithClassName: "_User", objectId: userObjectID)
        request.setObject(fromUserPointer, forKey: "fromUser")
        request.setObject(toUserPointer, forKey: "toUser")
        request.setObject("pending", forKey: "status")
        request.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
                println("Success friend request!")
            } else {
                // There was a problem, check error.description
                println(error)
            }
        }
    }
    static func getAllGroupsFromUser(){
        var query = PFQuery(className: "Group")
        query.whereKey("members", containsAllObjectsInArray: [PFObject(withoutDataWithClassName: "_User", objectId: PFUser.currentUser()?.objectId)])
        
        query.findObjectsInBackgroundWithBlock { (res:[AnyObject]?, err:NSError?) -> Void in
            if err == nil{
                if let res = res as? [PFObject] {
                    for obj in res {
                        var group = Group()
                        group.groupID = obj.objectId!
                        self.userGroups.append(group)
                        
                        
                    }
                }
            }else{
                println(err)
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