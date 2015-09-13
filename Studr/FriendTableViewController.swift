//
//  FriendTableViewController.swift
//  Studr
//
//  Created by Robin Onsay on 9/12/15.
//  Copyright (c) 2015 Joshua Herkness. All rights reserved.
//

import UIKit
import Parse

class FriendTableViewController: UITableViewController ,UISearchBarDelegate, UISearchDisplayDelegate{
    
    var popoverController : UIPopoverController?
    
    var friends = [PFObject]()
    var requests = [PFObject]()
    var users = [PFObject]()
    var allUsers = [[PFObject]]()
    // Current cell
    var cell : UITableViewCell?
    
    // Array of selected cells ( Index Path )
    var selectedCells = [NSIndexPath]()
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        initialize()
    }
    
    override init!(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initialize()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    /*
    self.filteredCandies = self.candies.filter({( candy: Candy) -> Bool in
    let categoryMatch = (scope == "All") || (candy.category == scope)
    let stringMatch = candy.name.rangeOfString(searchText)
    return categoryMatch && (stringMatch != nil)
    })
    */
//    func filterContentForSearchText(searchText: String) {
//        // Filter the array using the filter method
//        self.friends = self.friends.filter({( friend: String) -> Bool in
//            let categoryMatch = (scope == "All") || (friends.category == scope)
//            let stringMatch = friends.name.rangeOfString(searchText)
//            return categoryMatch && (stringMatch != nil)
//        })
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add a back button
        self.navigationItem.leftBarButtonItem=UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "backButtonTapped:")
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.tableFooterView = UIView(frame: CGRect.zeroRect)
        
    }
    
    // MARK: UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Calculate number of friends from the database
        if section < allUsers.count {
            return allUsers[section].count
        }else{
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel!.text = allUsers[indexPath.section][indexPath.row].objectForKey("username") as? String
        
        if(indexPath.section == 2){
            var button = UIButton.buttonWithType(.ContactAdd) as! UIButton
            cell.accessoryView = button;
        }
        
        var view: UIView = UIView()
        view.backgroundColor = UIColorFromHex(0xF68E20, alpha: 0.05)
        cell.selectedBackgroundView = view
        return cell;
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    //MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        var user = allUsers[indexPath.section][indexPath.row]
        var userId = user.valueForKey("objectId") as! String
        Database.requestFriend(userId)
        
    }
    
    func backButtonTapped(sender : UIButton) {
        
        var members = [String]()
        for indexPath:NSIndexPath in self.selectedCells {
            members.append(self.tableView.cellForRowAtIndexPath(indexPath)!.textLabel!.text!)
        }
        if let porpOver = self.popoverController {
            porpOver.dismissPopoverAnimated(true)
            porpOver.delegate?.popoverControllerDidDismissPopover!(porpOver)
        }
        else if self.parentViewController is UINavigationController {
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    // Generate UIColor from a HEX value
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}
