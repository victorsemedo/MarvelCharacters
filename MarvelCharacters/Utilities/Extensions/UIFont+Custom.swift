//
//  UIFont+Custom.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 14/01/21.
//

import UIKit

extension UIFont {
    
    static func marvelFont(withSize size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: "Marvel", size: size) else {
            return UIFont.boldSystemFont(ofSize: size)
        }
        return customFont
    }
}
