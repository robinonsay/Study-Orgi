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
    
    var logInViewController: LogInViewController!
    var signUpViewController: SignUpViewController!
    var groupViewController: GroupTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // Promt the user to log in if they havent already        
        if (PFUser.currentUser() == nil) {
            // Create Login view controller
            self.logInViewController = LogInViewController()
            self.logInViewController.delegate = self
            self.logInViewController.fields = (PFLogInFields.UsernameAndPassword | PFLogInFields.LogInButton
                | PFLogInFields.SignUpButton | PFLogInFields.PasswordForgotten)
            //Create sign up view controller
            self.signUpViewController = SignUpViewController()
            self.signUpViewController.delegate = self
            self.logInViewController.signUpController = signUpViewController
            
            // Present login view controller
            self.presentViewController(logInViewController, animated:false, completion: nil)
        }
        
        // Create a GroupViewController object
        self.groupViewController = GroupTableViewController(style: UITableViewStyle.Plain, className: "Group")
        navigationController!.pushViewController(self.groupViewController, animated: false)
    }
    
    // MARK: Parse Login
    
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
        
        if (!username.isEmpty || !password.isEmpty) {
            return true
        }else {
            return false
        }
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func logInViewControllerDidCancelLogIn(logInController: PFLogInViewController) {
        self.presentViewController(self.logInViewController, animated: true, completion: nil)
    }
    
    
    // MARK: Parse Signup
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        
        self.dismissViewControllerAnimated(false, completion: nil)
        
        var informationTableViewController:InformationTableViewController = InformationTableViewController()
        self.navigationController?.pushViewController(informationTableViewController, animated: true)
        
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?) {
        // Try again
        self.presentViewController(self.signUpViewController, animated: true, completion: nil)
    }

    
    func addTapped(sender:UIButton) {
        print("Hello")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



