//
//  UIColor-HexString.swift
//  MaulaTestProject
//
//  Created by MyMacbook on 9/2/17.
//  Copyright © 2017 MyMacbook. All rights reserved.
//


import UIKit
/**
 Add new functionality to an existing UIColor class, enumeration, or protocol type. This includes the ability to extend types for which you do not have access to the original source code (known as retroactive modeling).
 */
extension UIColor {
    /**
     The shorthand three-digit hexadecimal representation of color.
     #RGB defines to the color #RRGGBB.
     
     - parameter hexString: Three-digit hexadecimal value.
     - parameter withAlpha: 0.0 - 1.0. Custom CGFloat value of Alpha.

     */
    convenience init(hexString:String, withAlpha: CGFloat) {
        let hexString:NSString = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let scanner = NSScanner(string: hexString as String)
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        
        var color:UInt32 = 0
        scanner.scanHexInt(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:withAlpha)
    }
    
    /**
     The shorthand three-digit hexadecimal representation of color.
     #RGB defines to the color #RRGGBB.
     
     - parameter hexString: Three-digit hexadecimal value.
     - parameter withAlpha: 0.0 - 1.0. The default is 1.0.
     
     */
    convenience init(hexString:String) {
        self.init(hexString: hexString, withAlpha: 1)
    }
 
}