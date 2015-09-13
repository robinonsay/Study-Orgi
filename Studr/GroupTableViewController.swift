//
//  GroupTableViewController.swift
//  Studr
//
//  Created by Robin Onsay on 9/11/15.
//  Copyright (c) 2015 JJR. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import XLForm

class GroupTableViewController: PFQueryTableViewController {
    
    override init(style: UITableViewStyle, className: String?) {
        super.init(style:style, className: className)
        
    }
    
    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")

        self.parseClassName = "Group"
    }
    override func queryForTable() -> PFQuery {
        var query = PFQuery(className: self.parseClassName!)
        query.whereKey("members", containsAllObjectsInArray: [PFObject(withoutDataWithClassName: "_User", objectId: PFUser.currentUser()?.objectId)])
        return query
    }
    
   
        override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let identifier = "cell"
            var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? PFTableViewCell
            if cell == nil {
                cell = PFTableViewCell(style: .Default, reuseIdentifier: identifier)
            }
            
            
            cell!.textLabel!.text = self.objectAtIndexPath(indexPath)?.objectForKey("Title") as! String
           
            
            return cell!
        }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       // Database.getAllGroupsFromUser()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(false)
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        var rightAddBarButtonItem:UIBarButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: "addTapped:")
        self.navigationItem.setRightBarButtonItem(rightAddBarButtonItem, animated: false)
         var leftFriendsBarButtonItem:UIBarButtonItem = UIBarButtonItem(title: "Friends", style: UIBarButtonItemStyle.Plain, target: self, action: "friendsTapped:")
        self.navigationItem.setLeftBarButtonItem(leftFriendsBarButtonItem, animated: false)
        self.title = "Groups"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addTapped(sender:UIButton) {
        
        var createGroupViewController: CreateGroupViewController = CreateGroupViewController()
        navigationController?.pushViewController(createGroupViewController, animated: true)
    
    }

    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    func friendsTapped(sender:UIButton) {
        
        var friendTableViewController: FriendManagerTableViewController = FriendManagerTableViewController()
        navigationController?.pushViewController(friendTableViewController, animated: true)
    }
}



