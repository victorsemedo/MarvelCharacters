//
//  CharactersWidgetContent.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 18/01/21.
//

import WidgetKit

struct CharactersWidgetContent: TimelineEntry {
    var date = Date()
    
    let characters: [Character]
    
    var first: String? {
        return characters.count > 0 ? characters[0].name : ""
    }
    
    var second: String? {
        return characters.count > 1 ? characters[1].name : ""
    }
    
    var third: String? {
        return characters.count > 2 ? characters[2].name : ""
    }
}

