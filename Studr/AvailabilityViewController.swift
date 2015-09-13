//
//  AvailabilityViewController.swift
//  Studr
//
//  Created by Joshua Herkness on 9/12/15.
//  Copyright (c) 2015 Joshua Herkness. All rights reserved.
//

import UIKit
import Parse

class AvailabilityViewController: UIViewController {
    
    let padding : CGFloat = 20
    
    let a: UIButton = UIButton()
    let b: UIButton = UIButton()
    let c: UIButton = UIButton()
    let d: UIButton = UIButton()
    let e: UIButton = UIButton()
    let f: UIButton = UIButton()
    let g: UIButton = UIButton()
    
    var h:[UIButton] = [UIButton]()
    
    var dictionary: [String: Int] = [String: Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.setHidesBackButton(false, animated: false)
        self.title = "Avaiability"
        
        h = [a,b,c,d,e,f,g]
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        var submit: UIButton = UIButton(frame: CGRectMake(0, self.view.frame.height - 50, self.view.frame.width, 50))
        submit.backgroundColor = UIColorFromHex(0x13EB91, alpha: 1.0)
        submit.tintColor = UIColor.whiteColor()
        submit.setTitle("Submit", forState: UIControlState.Normal)
        submit.addTarget(self, action: "submitTapped:", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(submit)
        
        for var i = 0; i < h.count; i++ {
            var date:NSDate = NSDate().dateByAddingTimeInterval(NSTimeInterval(3600*24*i))
            dictionary[date.description] = 2
            print(date.description)
            
            var center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)
            var circleRadius : CGFloat = 60.0;
            var radius : CGFloat = self.view.frame.size.width / 2 - 100
            
            var angle : CGFloat = CGFloat(2 * M_PI) / 7.0
            var x : CGFloat = center.x + radius * cos(angle * CGFloat(i) - CGFloat(M_PI_2)) - circleRadius/2
            var y : CGFloat = center.y + radius * sin(angle * CGFloat(i) - CGFloat(M_PI_2)) - circleRadius/2
            h[i].frame = CGRectMake(x, y , circleRadius, circleRadius)
            h[i].layer.cornerRadius = circleRadius / 2.0
            h[i].backgroundColor = UIColorFromHex(0x13EB91, alpha: 1.0)
            h[i].addTarget(self, action: "buttonPressed:", forControlEvents: UIControlEvents.TouchDown)
            h[i].setTitle("\(i)" , forState: UIControlState.Normal)
            h[i].setTitle(getDayOfWeekLetter(date), forState: UIControlState.Normal)
            h[i].tintColor = UIColor.whiteColor()
            self.view.addSubview(h[i])
        
        }
        
        
    }
    
    func submitTapped(sender: UIButton){
        var vc:GroupTableViewController = GroupTableViewController(style: UITableViewStyle.Plain, className: "Users")
        //self.navigationController?.pushViewController(vc, animated: true)
        self.navigationController?.setViewControllers([vc, self], animated: false)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    func buttonPressed(sender:UIButton) {
        if let i = find(h, sender) {
            
            switch (Array(dictionary.values)[i]) {
            case (0):
                dictionary[Array(dictionary.keys)[i]] = 1
                sender.backgroundColor = UIColorFromHex(0xfbcb4f, alpha: 1.0)
                break
            case (1):
                dictionary[Array(dictionary.keys)[i]] = 2
                sender.backgroundColor = UIColorFromHex(0x13EB91, alpha: 1.0)
                break
            case (2):
                dictionary[Array(dictionary.keys)[i]] = 0
                sender.backgroundColor = UIColorFromHex(0xF5205C, alpha: 1.0)
                break
            default:
                dictionary[Array(dictionary.keys)[i]] = 0
                sender.backgroundColor = UIColorFromHex(0xF5205C, alpha: 1.0)
            }
        }
    }
    
    func getDayOfWeek(date:NSDate)->Int? {
        let weekday = NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitWeekday, fromDate: date).weekday
        return weekday
    }
    
    func getDayOfWeekLetter(date:NSDate)->String? {
        let weekday = NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitWeekday, fromDate: date).weekday
        var weekdayLetter: String
        switch weekday {
        case 1:
            weekdayLetter = "Su"
            break
        case 2:
            weekdayLetter = "M"
            break
        case 3:
            weekdayLetter = "T"
            break
        case 4:
            weekdayLetter = "W"
            break
        case 5:
            weekdayLetter = "R"
            break
        case 6:
            weekdayLetter = "Fr"
            break
        case 7:
            weekdayLetter = "Sa"
            break
        default:
            weekdayLetter = ""
            
        }
        return weekdayLetter
    }
    
    // Generate a UIColor from a HEX value
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
}

