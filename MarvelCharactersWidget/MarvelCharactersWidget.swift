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
//        var entries: [CharactersWidgetContent] = []
//
//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = CharactersWidgetContent(date: entryDate)
//            entries.append(entry)
//        }

        let entries = [snapshotEntry]
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
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
        }
        .configurationDisplayName("Marvel Characters")
        .description("The first three characters")
        .supportedFamilies([.systemMedium])
    }
}
