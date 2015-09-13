//
//  FriendManagerTableViewController.swift
//  Studr
//
//  Created by Joseph Herkness on 9/13/15.
//  Copyright (c) 2015 Joshua Herkness. All rights reserved.
//

import Foundation
import ParseUI
import Parse

class FriendManagerTableViewController : PFQueryTableViewController {
    
    override init(style: UITableViewStyle, className: String?) {
        super.init(style: style, className: className)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Configure the PFQueryTableView
        parseClassName = "_User"
        
        self.textKey = "username"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
    }
    
    // Define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery {
        var query = PFQuery(className: "_User")
        query.orderByAscending("username")
        
        return query
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        
        // Extract values from the PFObject to display in the table cell
        var cell = PFTableViewCell()
        cell.textLabel!.text = object?.valueForKey("username") as? String
        var button = UIButton.buttonWithType(.ContactAdd) as! UIButton
        cell.accessoryView = button;
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var obj = objectAtIndexPath(indexPath)
        var objId = obj?.valueForKey("objectId") as! String
        Database.requestFriend(objId)
    }
}