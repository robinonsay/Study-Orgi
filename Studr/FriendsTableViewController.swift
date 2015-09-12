//
//  FriendsTableViewController.swift
//  Studr
//
//  Created by Joshua Herkness on 9/12/15.
//  Copyright (c) 2015 JJR. All rights reserved.
//

import UIKit
import XLForm


class FriendsTableViewController : UITableViewController, XLFormRowDescriptorViewController, XLFormRowDescriptorPopoverViewController {
    
    
    
    var rowDescriptor : XLFormRowDescriptor?
    var popoverController : UIPopoverController?
    
    var cell : UITableViewCell?
    
    var selectedCells = [NSIndexPath]()
    
    private let kUserCellIdentifier = "cell"
    
    
    override init(style: UITableViewStyle) {
        super.init(style: style);
    }
    
    override init!(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem=UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "backButtonTapped:")
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: self.kUserCellIdentifier)
        self.tableView.tableFooterView = UIView(frame: CGRect.zeroRect)
        
    }
    
    // MARK: UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Calculate number of cells in the section
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(self.kUserCellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel!.text = "\(indexPath.row)"
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
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
}