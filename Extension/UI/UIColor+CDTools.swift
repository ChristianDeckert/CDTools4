//
//  UIColor+CDTools.swift
//
//
//  Created by Christian Deckert on 20.10.14.
//  Copyright (c) 2016 Christian Deckert. All rights reserved.
//

import Foundation
import UIKit

/// Creates a `UIColor` from the given RGB values where alpha is set to 1 (fully opaque).
///
/// - parameters:
///   - r: red component as `CGFloat` [0-1]
///   - g: green component as `CGFloat` [0-1]
///   - b: blue component as `CGFloat` [0-1]
/// - returns: the new `UIColor` object

public func rgb(_ r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
    return rgba(r, g: g, b: b, a: 1)
}

/// Creates a `UIColor` from the given RGBA values.
///
/// - parameters:
///   - r: red component as `CGFloat` [0-1]
///   - g: green component as `CGFloat` [0-1]
///   - b: blue component as `CGFloat` [0-1]
///   - a: alpha component as `CGFloat` [0-1]
/// - returns: the new `UIColor` object
public func rgba(_ r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

public extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hexInt netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    convenience init(hexString hex: String) {
        self.init(hexInt: Int(hex) ?? 0)
    }
    
    public class func colorFromString(_ colorString: String) -> UIColor? {
        let components = colorString.components(separatedBy: ";")
        
        var color: UIColor?
        if components.count == 3 {
            let red: NSString = components[0] as NSString
            let green: NSString = components[1] as NSString
            let blue: NSString = components[2] as NSString
            let r = CGFloat(red.floatValue / 255.0)
            let g = CGFloat(green.floatValue / 255.0)
            let b = CGFloat(blue.floatValue / 255.0)
            color = UIColor(red: r, green: g, blue: b, alpha: 1.0)
        }
        
        return color
    }
    
    /// Returns RGB seperated by ";"
    public var colorString: String {
        
        let numberOfComponents = self.cgColor.numberOfComponents
        var colorString = ""
        
        if (numberOfComponents == 2) {
            if let components = self.cgColor.components {
                let compR = components[0]
                
                colorString = NSString(format: "%li;%li;%li", Int(compR * 255.0), Int(compR * 255.0), Int(compR * 255.0)) as String
            }
        }
        if (numberOfComponents > 3) {
            if let components = self.cgColor.components {
                let compR = components[0]
                let compG = components[1]
                let compB = components[2]
                //            let compA = components[3]
                
                colorString = NSString(format: "%li;%li;%li", Int(compR * 255.0), Int(compG * 255.0), Int(compB * 255.0)) as String
            }
        }
        return colorString
    }
    
    public static func colorWithHexString (_ hex: String) -> UIColor {
        var cString:String = (hex as NSString).trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if ((cString as NSString).length != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
    public var hexString: String {
        
        var hexString = "#000000"
        
        let numberOfComponents = self.cgColor.numberOfComponents
        let components = self.cgColor.components!
        if numberOfComponents >= 3 {
            let r = components[0]
            let g = components[1]
            let b = components[2]
            
            hexString = NSString(format: "#%02X%02X%02X", Int16(r * 255), Int16(g * 255), Int16(b * 255)) as String
        }
        return hexString as String
    }
    
    
    public static var randomColor: UIColor {
        let red = CGFloat(Double(arc4random() % 256) / 256.0)
        let green = CGFloat(Double(arc4random() % 256) / 256.0)
        let blue = CGFloat(Double(arc4random() % 256) / 256.0)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    public var isLight: Bool
    {
        let components = self.cgColor.components!
        let brightness = ((components[0] * CGFloat(299.0)) + (components[1] * CGFloat(587.0)) + (components[2] * CGFloat(114.0))) / CGFloat(1000.0)
        
        if brightness < 0.5
        {
            return false
        }
        else
        {
            return true
        }
    }
    
    public var isVeryLight: Bool
    {
        let components = self.cgColor.components!
        let brightness = ((components[0] * CGFloat(299)) + (components[1] * CGFloat(587)) + (components[2] * CGFloat(114))) / CGFloat(1000)
        
        if brightness < 0.85
        {
            return false
        }
        else
        {
            return true
        }
    }
}
