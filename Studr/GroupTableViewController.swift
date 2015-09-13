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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Database.getAllGroupsFromUser()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(false)
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        var rightAddBarButtonItem:UIBarButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: "addTapped:")
        self.navigationItem.setRightBarButtonItem(rightAddBarButtonItem, animated: false)
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
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        
        var query = PFQuery(className:"Group")
        var group = query.getObjectWithId(Database.userGroups[indexPath.row].groupID)
        cell.textLabel!.text = group?.objectForKey("Title") as? String
        var view: UIView = UIView()
        view.backgroundColor = UIColorFromHex(0xF68E20, alpha: 0.05)
        cell.selectedBackgroundView = view
//        if self.rowDescriptor?.value != nil {
//            
//            cell.accessoryType = contains(self.rowDescriptor!.value as! [String], cell.textLabel!.text!) ? .Checkmark : .None
//            
//            if contains(self.rowDescriptor!.value as! [String], cell.textLabel!.text!){
//                self.selectedCells.append(indexPath)
//            }
//        }
        return cell;

    }
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}



