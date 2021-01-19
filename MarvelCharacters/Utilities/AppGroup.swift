//
//  AppGroup.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 18/01/21.
//

import Foundation

enum FileName: String {
    case firstCharacters = "FirstCharacters"
}

enum AppGroup: String {
    case characters = "group.com.semedo.MarvelCharacters"
    
    public var containerURL: URL {
        switch self {
        case .characters:
            return FileManager.default.containerURL(
                  forSecurityApplicationGroupIdentifier: self.rawValue)!
        }
    }
    
    func filePath(_ name: FileName) -> URL {
        return containerURL.appendingPathComponent(name.rawValue)
    }
}
