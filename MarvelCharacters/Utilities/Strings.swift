//
//  Strings.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 16/01/21.
//

import Foundation


public protocol Localizable {
    var localizable: String { get }
    
    var bundle: Bundle { get }
}

public extension Localizable where Self: RawRepresentable, RawValue == String {
    var localizable: String {
        return NSLocalizedString(rawValue, bundle: bundle, comment: "")
    }
    
    var bundle: Bundle {
        return Bundle.main
    }
}

enum Strings: String, Localizable {
    case characters
    case favorites
    case searchByName = "search_by_name"
    case comics
    case series
}
