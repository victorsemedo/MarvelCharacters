//
//  MockReader.swift
//  MarvelCharactersTests
//
//  Created by Victor Tavares on 10/01/21.
//

import Foundation

enum MockFile: String {
    case characters = "characters"
    case comics = "comics"
    case series = "series"
    
    var fileExtension: String {
        return "json"
    }
}

class MockReader {
    
    private init() { }
    
    public static var bundle: Bundle {
        return Bundle(for: MockReader.self)
    }
    
    static func loadData(fromFile file: MockFile) -> Data? {
        guard let url = MockReader.bundle.url(forResource: file.rawValue, withExtension: file.fileExtension) else {
            return nil
        }
        return try? Data(contentsOf: url)
    }
    
    static func decodeOject<T:Codable>(fromData data: Data) -> T? {
        let decoder = JSONDecoder()
        let jsonData = try? decoder.decode(T.self, from: data)
        return jsonData
    }
    
    static func decodeOject<T:Codable>(fromFile file: MockFile) -> T? {
        guard let data = loadData(fromFile: file) else {
            return nil
        }
        return decodeOject(fromData: data)
    }
}

