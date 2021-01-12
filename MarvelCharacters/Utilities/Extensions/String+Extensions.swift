//
//  String+Extension.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 10/01/21.
//

import Foundation
import CryptoKit

extension String {
    
    func md5() -> String {
        let hash = Insecure.MD5.hash(data: self.data(using: .utf8) ?? Data())
        return hash.map {String(format: "%02hhx", $0)}.joined()
    }
}

