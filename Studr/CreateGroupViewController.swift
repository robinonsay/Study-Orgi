//
//  JHCreateGroupViewController.swift
//  Studr
//
//  Created by Joshua Herkness on 9/12/15.
//  Copyright (c) 2015 JJR. All rights reserved.
//

import UIKit
import Parse
import XLForm

class CreateGroupViewController: XLFormViewController {
    
    // Form list
    private enum Tags : String {
        case Title = "title"
        case Description = "description"
        case Location = "location"
        case Access = "access"
        case Private = "private"
        case Members = "members"
        case Submit = "submit"
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.initializeForm()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initializeForm()
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        self.initializeForm()
    }
    
    func initializeForm() {
        
        let form : XLFormDescriptor
        var section : XLFormSectionDescriptor
        var row : XLFormRowDescriptor
        
        form = XLFormDescriptor(title: "Group Settings")
        form.assignFirstResponderOnShow = true
        
        section = XLFormSectionDescriptor.formSectionWithTitle("Group Settings")
        section.footerTitle = ""
        form.addFormSection(section)
        
        
        // Title
        row = XLFormRowDescriptor(tag: Tags.Title.rawValue, rowType: XLFormRowDescriptorTypeText)
        row.required = true
        row.cellConfigAtConfigure["textField.placeholder"] = "Title"
        row.cellConfig["self.tintColor"] = UIColorFromHex(0xF68E20, alpha: 1.0)
        section.addFormRow(row)
        
        // Description
        row = XLFormRowDescriptor(tag: Tags.Description.rawValue, rowType: XLFormRowDescriptorTypeTextView)
        row.required = false
        row.cellConfigAtConfigure["textView.placeholder"] = "Description"
        row.cellConfig["self.tintColor"] = UIColorFromHex(0xF68E20, alpha: 1.0)
        section.addFormRow(row)
        
        // Locaiton
        row = XLFormRowDescriptor(tag: Tags.Location.rawValue, rowType: XLFormRowDescriptorTypeText)
        row.cellConfigAtConfigure["textField.placeholder"] = "Location"
        row.required = true
        row.cellConfig["self.tintColor"] = UIColorFromHex(0xF68E20, alpha: 1.0)
        section.addFormRow(row)
        
        // Private
        row = XLFormRowDescriptor(tag: Tags.Private.rawValue, rowType: XLFormRowDescriptorTypeBooleanSwitch, title: "Private")
        row.required = false
        row.cellConfig["self.tintColor"] = UIColorFromHex(0xF68E20, alpha: 1.0)
        section.addFormRow(row)
        
        // Members
        row = XLFormRowDescriptor(tag: Tags.Members.rawValue, rowType: XLFormRowDescriptorTypeSelectorPush, title: "Add Members")
        row.required = false
        row.cellConfig["self.tintColor"] = UIColorFromHex(0xF68E20, alpha: 1.0)
        row.action.viewControllerClass = FriendsTableViewController.self
        section.addFormRow(row)
        
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
            // Selector PopOver
            row = XLFormRowDescriptor(tag: "selectorUserPopover", rowType:XLFormRowDescriptorTypeSelectorPopover, title:"Members")
            row.action.viewControllerClass = FriendsTableViewController.self
            section.addFormRow(row)
        }
        
        // New Section
        section = XLFormSectionDescriptor.formSectionWithTitle("")
        section.footerTitle = "Carfted with ♥ at MHAcks"
        form.addFormSection(section)
        
        //Submit
        row = XLFormRowDescriptor(tag: Tags.Submit.rawValue, rowType: XLFormRowDescriptorTypeButton, title: "Submit")
        row.cellConfig["backgroundColor"] = UIColorFromHex(0x13EB91, alpha: 1.0)
        row.cellConfig["textLabel.textColor"] = UIColor.whiteColor()
        row.action.formSelector = "submitTapped:";
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
    
    func submitTapped(sender: UIButton){
        
        // Dictionary of results
        var dictionary:Dictionary = self.formValues()
        
        // Store in database here
        
        // Move on
        var a: AvailabilityViewController = AvailabilityViewController()
        navigationController?.pushViewController(a, animated: true)
        
    }
    
    // Generate UIColor from HEX value
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}