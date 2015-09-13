//
//  InformationTableViewController.swift
//  Studr
//
//  Created by Joshua Herkness on 9/12/15.
//  Copyright (c) 2015 JJR. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import XLForm

class InformationTableViewController: XLFormViewController {
    
    // Form objects
    private enum Tags : String {
        case First = "first"
        case Last = "last"
        case School = "school"
        case Major = "major"
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
        
        form = XLFormDescriptor(title: "About")
        form.assignFirstResponderOnShow = true
        
        section = XLFormSectionDescriptor.formSectionWithTitle("About")
        section.footerTitle = ""
        form.addFormSection(section)
        
        // First
        row = XLFormRowDescriptor(tag: Tags.First.rawValue, rowType: XLFormRowDescriptorTypeText)
        row.required = true
        row.cellConfigAtConfigure["textField.placeholder"] = "First Name"
        row.cellConfig["self.tintColor"] = UIColorFromHex(0xF68E20, alpha: 1.0)
        section.addFormRow(row)
        
        // Last
        row = XLFormRowDescriptor(tag: Tags.Last.rawValue, rowType: XLFormRowDescriptorTypeText)
        row.required = true
        row.cellConfigAtConfigure["textField.placeholder"] = "Last Name"
        row.cellConfig["self.tintColor"] = UIColorFromHex(0xF68E20, alpha: 1.0)
        section.addFormRow(row)
        
        // School
        row = XLFormRowDescriptor(tag: Tags.School.rawValue, rowType: XLFormRowDescriptorTypeText)
        row.cellConfigAtConfigure["textField.placeholder"] = "School"
        row.cellConfig["self.tintColor"] = UIColorFromHex(0xF68E20, alpha: 1.0)
        section.addFormRow(row)
        
        // Major
        row = XLFormRowDescriptor(tag: Tags.Major.rawValue, rowType: XLFormRowDescriptorTypeText)
        row.cellConfigAtConfigure["textField.placeholder"] = "Major"
        row.cellConfig["self.tintColor"] = UIColorFromHex(0xF68E20, alpha: 1.0)
        section.addFormRow(row)
        
        
        // New Section
        section = XLFormSectionDescriptor.formSectionWithTitle("")
        section.footerTitle = "Carfted with ♥ at MHAcks"
        form.addFormSection(section)
        
        //Submit
        row = XLFormRowDescriptor(tag: Tags.Submit.rawValue, rowType: XLFormRowDescriptorTypeButton, title: "Submit")
        row.required = true
        row.cellConfig["backgroundColor"] = UIColorFromHex(0x13EB91, alpha: 1.0)
        row.cellConfig["textLabel.textColor"] = UIColor.whiteColor()
        row.action.formSelector = "submitTapped:";
        section.addFormRow(row)
        
        self.form = form
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Aditional setup here
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func submitTapped(sender: UIButton){
        
        // Dictionary of results
        var dictionary:Dictionary = self.formValues()
        print(dictionary)
        
        // Store in database here
        
        
        // If the user is not already signed in, prompt them to sign in
        if PFUser.currentUser() == nil {
            
            var loginViewController: LogInViewController = LogInViewController()
            
            loginViewController.fields = (PFLogInFields.UsernameAndPassword
                | PFLogInFields.LogInButton
                | PFLogInFields.SignUpButton
                | PFLogInFields.PasswordForgotten)
            
            self.presentViewController(loginViewController, animated: true, completion: nil)
            
        } else {
            
            self.dismissViewControllerAnimated(true, completion: nil)
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