//
//  Color+Extensions.swift
//  MarvelCharactersWidgetExtension
//
//  Created by Victor Tavares on 19/01/21.
//

import SwiftUI

extension Color {
    
    static let primaryRed = Color(hex: 0xD42503)
    static let captainSafetyYellow =  Color(hex: 0xF3D403)
    static let captainCelticBlue =  Color(hex: 0x2A75B3)
    
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
