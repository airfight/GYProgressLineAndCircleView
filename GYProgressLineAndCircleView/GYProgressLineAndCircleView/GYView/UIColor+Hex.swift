//
//  UIColor+Hex.swift
//  GYProgressLineAndCircleView
//
//  Created by ZGY on 2017/1/16.
//  Copyright © 2017年 GYJade. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/1/16  18:45
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

extension UIColor {
    
//    public func colorWithHex(_ hexString: String,alpha: CGFloat? = 1.0) -> UIColor {
    
//        self(
        
//        let hexint = Int(self.)
//        return UIColor.white
//        
//    }
    
    convenience init(hex: String) {
        
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r)/0xff,
            green: CGFloat(g)/0xff,
            blue: CGFloat(b)/0xff,
            alpha:1)
        
    }
    
}
