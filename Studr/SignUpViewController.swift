//
//  SignUpViewController.swift
//  Studr
//
//  Created by Joshua Herkness on 9/12/15.
//  Copyright (c) 2015 Joshua Herkness. All rights reserved.
//

import UIKit
import ParseUI

class SignUpViewController : PFSignUpViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logoView = UIImageView(image: UIImage(named:"logo.png"))
        logoView.contentMode = UIViewContentMode.ScaleAspectFit
        self.signUpView!.logo = logoView
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.signUpView!.signUpButton?.setBackgroundImage(nil, forState: .Normal)
        self.signUpView!.signUpButton?.setBackgroundImage(nil, forState: .Highlighted)
        self.signUpView!.signUpButton?.backgroundColor = UIColorFromHex(0xF68E20, alpha: 1.0)
    }
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}
