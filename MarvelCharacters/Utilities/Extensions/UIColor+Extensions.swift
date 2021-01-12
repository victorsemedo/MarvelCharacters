//
//  UIColor+Extension.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 10/01/21.
//

import UIKit

public extension UIColor {

    convenience init(hex: String) {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        let hex = hex.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hex)
        var hexValue: CUnsignedLongLong = 0
        if scanner.scanHexInt64(&hexValue) {
            switch hex.count {
            case 3:
                red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                blue  = CGFloat(hexValue & 0x00F)              / 15.0
            case 4:
                alpha   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                red = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                green  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                blue = CGFloat(hexValue & 0x000F)             / 15.0
            case 6:
                red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
            case 8:
                alpha = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                red   = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                green = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                blue  = CGFloat(hexValue & 0x000000FF)         / 255.0
            default:
                red = 0.0
                green = 0.0
                blue = 0.0
            }
        }

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
