//
//  DetailGroupViewController.swift
//  Studr
//
//  Created by Joshua Herkness on 9/12/15.
//  Copyright (c) 2015 JJR. All rights reserved.
//

import UIKit
import Parse
import XLForm

class DetailGroupViewController: XLFormViewController {
    
    var group:PFObject = PFObject(className: "Group")
    
    // Form list
    private enum Tags : String {
        case Description = "description"
        case Location = "location"
        case Date = "date"
        case Members = "members"
        case Leave = "Leave"
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.initializeForm()
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initializeForm()
    }
    
    convenience init(group:PFObject) {
        self.init(nibName: nil, bundle: nil)
        print("----------------------------------")
        self.group = group
        self.initializeForm()
                       self.group.fetch()
        print("\n\n\n\n\n\n\n")
        println(self.group)
    }
    
    func initializeForm() {
                group.fetch()
        let form : XLFormDescriptor
        var section : XLFormSectionDescriptor
        var row : XLFormRowDescriptor
        
        form = XLFormDescriptor(title: group.valueForKey("Title") as? String)
        form.assignFirstResponderOnShow = true
        
        section = XLFormSectionDescriptor.formSectionWithTitle("")
        section.footerTitle = ""
        form.addFormSection(section)
        
        
        // Description
        row = XLFormRowDescriptor(tag: Tags.Description.rawValue, rowType: XLFormRowDescriptorTypeTextView, title: "Description")
        row.value = group.objectForKey("Description") as? String
        row.disabled = true
        row.cellConfig["self.tintColor"] = UIColorFromHex(0xF68E20, alpha: 1.0)
        section.addFormRow(row)
        
        // Location
        row = XLFormRowDescriptor(tag: Tags.Location.rawValue, rowType: XLFormRowDescriptorTypeText, title: "Location")
        row.value = group.objectForKey("Location") as? String
        row.disabled = true
        row.cellConfig["self.tintColor"] = UIColorFromHex(0xF68E20, alpha: 1.0)
        section.addFormRow(row)
        
        // Date
        row = XLFormRowDescriptor(tag: Tags.Date.rawValue, rowType: XLFormRowDescriptorTypeText, title: "Date")
        row.disabled = true
        var dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        var a = group.valueForKey("bestDate") as! String!
        row.value = a
        row.cellConfig["self.tintColor"] = UIColorFromHex(0xF68E20, alpha: 1.0)
        section.addFormRow(row)
        
        // Members
        row = XLFormRowDescriptor(tag: Tags.Members.rawValue, rowType: XLFormRowDescriptorTypeSelectorPush, title: "Members")
        row.required = false
        row.cellConfig["self.tintColor"] = UIColorFromHex(0xF68E20, alpha: 1.0)
        //row.action.viewControllerClass = FriendsTableViewController.self
        section.addFormRow(row)
        
        /*
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
            // Selector PopOver
            row = XLFormRowDescriptor(tag: "selectorUserPopover", rowType:XLFormRowDescriptorTypeSelectorPopover, title:"Members")
            row.action.viewControllerClass = FriendsTableViewController.self
            section.addFormRow(row)
        }
        */
        
        // New Section
        section = XLFormSectionDescriptor.formSectionWithTitle("")
        section.footerTitle = "Carfted with ♥ at MHAcks"
        form.addFormSection(section)
        
        //Leave
        row = XLFormRowDescriptor(tag: Tags.Leave.rawValue, rowType: XLFormRowDescriptorTypeButton, title: "Leave")
        row.cellConfig["backgroundColor"] = UIColorFromHex(0xF5205C, alpha: 1.0)
        row.cellConfig["textLabel.textColor"] = UIColor.whiteColor()
        row.action.formSelector = "leaveTapped:";
        section.addFormRow(row)
        
        self.form = form
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func leaveTapped(sender: UIButton){
        
        // Leave Group Here
        
        // Move on
        var vc:GroupTableViewController = GroupTableViewController(style: UITableViewStyle.Plain, className: "Users")
        //self.navigationController?.pushViewController(vc, animated: true)
        self.navigationController?.setViewControllers([vc, self], animated: false)
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    // Generate UIColor from HEX value
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}