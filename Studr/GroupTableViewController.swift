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
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(false)
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        var rightAddBarButtonItem:UIBarButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: "addTapped:")
        self.navigationItem.setRightBarButtonItem(rightAddBarButtonItem, animated: false)
         var leftFriendsBarButtonItem:UIBarButtonItem = UIBarButtonItem(title: "Friends", style: UIBarButtonItemStyle.Plain, target: self, action: "friendsTapped:")
        self.navigationItem.setLeftBarButtonItem(leftFriendsBarButtonItem, animated: false)
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
    func friendsTapped(sender:UIButton) {
        
        var friendTableViewController: FriendTableViewController = FriendTableViewController()
        navigationController?.pushViewController(friendTableViewController, animated: true)
    }
}



