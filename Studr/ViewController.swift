//
//  ViewController.swift
//  Studr
//
//  Created by Robin Onsay on 9/11/15.
//  Copyright (c) 2015 JJR. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    var logInViewController:PFLogInViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(false)
        let userPointer = PFObject(withoutDataWithClassName:"_User", objectId: "PZgt6F5FZZ")
        let groupPointer = PFObject(withoutDataWithClassName: "Groups", objectId: "PLkREcfsg5")
        //Group.rmvMember2("PZgt6F5FZZ", memberObjectID: "WgSoR4YDBe")
        var date = NSDate(timeIntervalSinceNow: 6000)
        Group.mkGroup("Hello World", description: "This is a hello world group", ppublic: true, creatorID: "PZgt6F5FZZ", startDate: NSDate(), endDate: date)
        //Group.rmvMember("PLkREcfsg5", userID: "PZgt6F5FZZ")
//        Group.rmvMember(userPointer, userID: groupPointer)
        // Create Login view controller
        logInViewController = PFLogInViewController()
        logInViewController.delegate = self
        logInViewController.fields = (PFLogInFields.UsernameAndPassword
                                        | PFLogInFields.LogInButton
                                        | PFLogInFields.SignUpButton
                                        | PFLogInFields.PasswordForgotten)
        
        self.presentViewController(logInViewController, animated:true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {

    }
    
}

