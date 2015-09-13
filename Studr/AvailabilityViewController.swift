//
//  AvailabilityViewController.swift
//  Studr
//
//  Created by Joshua Herkness on 9/12/15.
//  Copyright (c) 2015 Joshua Herkness. All rights reserved.
//

import UIKit
import Parse

class AvailabilityViewController: ViewController {
    
    let padding : CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var a: UIButton = UIButton()
        var b: UIButton = UIButton()
        var c: UIButton = UIButton()
        var d: UIButton = UIButton()
        var e: UIButton = UIButton()
        var f: UIButton = UIButton()
        var g: UIButton = UIButton()
        
        var h:[UIButton] = [a,b,c,d,e,f,g]
        var dictionary: [String: Int]
        
        for var i = 0; i < h.count; i++ {
            var date:NSDate = NSDate().dateByAddingTimeInterval(NSTimeInterval(3600*24*i))
            dictionary = [date.description: 2]
            
            var r : CGFloat = (self.view.frame.size.height - padding * CGFloat(i)) / CGFloat(2 * i)
            var x : CGFloat = self.view.frame.size.width / 2.0 - r
            var y : CGFloat = (CGFloat(self.view.frame.width) / 2.0) - self.view.frame.height - padding * CGFloat(i) / 2.0 * CGFloat(i)
            h[i].frame = CGRectMake(x, y , r*2, r*2)
            h[i].layer.cornerRadius = r
            h[i].addTarget(self, action: "buttonTapped:", forControlEvents: UIControlEvents.TouchDown)
            self.view.addSubview(h[i])
        
        }
    }

    
    /*
    func getAvailability() -> [String:Int] {
        return nil
    }
    */
    
}

