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
    
    var logInViewController: PFLogInViewController!
    var groupViewController: GroupTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Database.requestFriend("q5qFQTyu0n")
        //Database.acceptFriend("PLKREcfsg5")
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(false)
        
        PFUser.logOut()
        
        // If there is currently no user logged in, promt the user to login
        if (PFUser.currentUser() == nil) {
            // Create Login view controller
            self.logInViewController = PFLogInViewController()
            self.logInViewController.delegate = self
            self.logInViewController.fields = (PFLogInFields.UsernameAndPassword
                | PFLogInFields.LogInButton
                | PFLogInFields.SignUpButton
                | PFLogInFields.PasswordForgotten)
            self.logInViewController.emailAsUsername = true
            
            self.presentViewController(logInViewController, animated:true, completion: nil)
        }
        
        // Create a GroupViewController object
        self.groupViewController = GroupTableViewController(style: UITableViewStyle.Plain, className: "Users")
        
        navigationController!.pushViewController(self.groupViewController, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
    }
    
    
    // MARK: Parse Signup
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        
        self.presentViewController(self.logInViewController, animated: true, completion: nil)
        
    }
    
    /*
    func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?) {
    
    println("FAiled to sign up...")
    
    }
    */
    
    func addTapped(sender:UIButton) {
        print("Hello")
    }
}



