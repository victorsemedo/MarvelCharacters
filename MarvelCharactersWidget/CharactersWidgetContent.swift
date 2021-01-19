//
//  CharactersWidgetContent.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 18/01/21.
//

import WidgetKit
import UIKit

struct CharactersWidgetContent: Codable, TimelineEntry {
    var date = Date()
    
    var characters: [Character]
}
