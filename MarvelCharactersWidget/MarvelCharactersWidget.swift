//
//  MarvelCharactersWidget.swift
//  MarvelCharactersWidget
//
//  Created by Victor Tavares on 18/01/21.
//

import WidgetKit
import SwiftUI

let snapshotEntry = CharactersWidgetContent(characters: [Character(id: 10, name: "teste1", description: "teste1"), Character(id: 10, name: "teste2", description: "teste2"), Character(id: 10, name: "teste3", description: "teste1")])

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> CharactersWidgetContent {
        snapshotEntry
    }
    
    func getSnapshot(in context: Context, completion: @escaping (CharactersWidgetContent) -> ()) {
        let entry = snapshotEntry
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entry = readContent()
        let currentDate = Date()
        let interval = 1
        
        entry.date = Calendar.current.date(byAdding: .month, value: interval, to: currentDate)!
        
        let imageRequestGroup = DispatchGroup()
        for index in 0..<entry.characters.count {
            imageRequestGroup.enter()
            self.getCharacterImage(character: entry.characters[index]) { (image) in
                entry.characters[index].image = image
                imageRequestGroup.leave()
            }
        }
        
        imageRequestGroup.notify(queue: .main) {
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }
    
    func readContent() -> CharactersWidgetContent {
        var content: CharactersWidgetContent = snapshotEntry
        
        let archiveURL = AppGroup.characters.filePath(.firstCharacters)
        
        if let codeData = try? Data(contentsOf: archiveURL) {
            do {
                content = try JSONDecoder().decode(CharactersWidgetContent.self, from: codeData)
            } catch {
                print("Error: Can't decode CharactersWidgetContent")
            }
        }
        
        for index in 0..<content.characters.count {
            self.getCharacterImage(character: content.characters[index]) { (image) in
                content.characters[index].image = image
            }
        }
        
        return content
    }
    
    func getCharacterImage(character: Character, completion: @escaping (UIImage?) -> ()) {
        guard let imageUrl = character.imageUrl,
              let url = URL(string: imageUrl) else {
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { (data, respose, error) in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            completion(UIImage(data: data))
        }.resume()
    }
}

@main
struct MarvelCharactersWidget: Widget {
    
    private let kind: String = "MarvelCharactersWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: Provider()
        ) { entry in
            CharactersWidgetView(model: entry)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.captainCelticBlue)
        }
        .configurationDisplayName("Marvel Characters")
        .description("The first three characters")
        .supportedFamilies([.systemMedium])
    }
}
