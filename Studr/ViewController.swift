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
        var group = Group()
        Group.addMember("PZgt6F5FZZ", userID: "PLkREcfsg5")
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

