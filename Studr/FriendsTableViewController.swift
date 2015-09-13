//
//  FriendsTableViewController.swift
//  Studr
//
//  Created by Joshua Herkness on 9/12/15.
//  Copyright (c) 2015 JJR. All rights reserved.
//

import UIKit
import XLForm
import Parse

class FriendsTableViewController : UITableViewController, XLFormRowDescriptorViewController, XLFormRowDescriptorPopoverViewController {
    var friends = [String]()
    var rowDescriptor : XLFormRowDescriptor?
    var popoverController : UIPopoverController?
    
    // Current cell
    var cell : UITableViewCell?
    
    // Array of selected cells ( Index Path )
    var selectedCells = [NSIndexPath]()
    
    override init(style: UITableViewStyle) {
        super.init(style: style);
        friends = Database.getAcceptedFriends()
    }
    
    override init!(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        friends = Database.getAcceptedFriends()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        friends = Database.getAcceptedFriends()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add a back button
        self.navigationItem.leftBarButtonItem=UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "backButtonTapped:")
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.tableFooterView = UIView(frame: CGRect.zeroRect)
        
    }
    
    // MARK: UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1 // Should always be 1 in this case
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Calculate number of friends from the database
        return friends.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel!.text = friends[indexPath.row].objectForKey("userName") as? String
        var view: UIView = UIView()
        view.backgroundColor = UIColorFromHex(0xF68E20, alpha: 0.05)
        cell.selectedBackgroundView = view
        if self.rowDescriptor?.value != nil {
            
            cell.accessoryType = contains(self.rowDescriptor!.value as! [String], cell.textLabel!.text!) ? .Checkmark : .None
            
            if contains(self.rowDescriptor!.value as! [String], cell.textLabel!.text!){
                self.selectedCells.append(indexPath)
            }
        }
        return cell;
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    //MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        if (contains(self.selectedCells, indexPath)){
            
            cell!.accessoryType = UITableViewCellAccessoryType.None;
            self.selectedCells = self.selectedCells.filter() { $0 !== indexPath }
            
        }else{
            
            cell!.accessoryType = UITableViewCellAccessoryType.Checkmark;
            self.selectedCells.append(indexPath)
        }
        
        print(self.selectedCells)
    }
    
    func backButtonTapped(sender : UIButton) {
        
        var members = [String]()
        for indexPath:NSIndexPath in self.selectedCells {
            members.append(self.tableView.cellForRowAtIndexPath(indexPath)!.textLabel!.text!)
        }
        
        self.rowDescriptor!.value = members
        
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