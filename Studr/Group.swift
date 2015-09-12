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
}