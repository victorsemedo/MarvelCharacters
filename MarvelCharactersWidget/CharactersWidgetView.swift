//
//  CharactersWidgetView.swift
//  MarvelCharactersWidgetExtension
//
//  Created by Victor Tavares on 18/01/21.
//

import SwiftUI

struct CharactersWidgetView: View {
    let model: CharactersWidgetContent
    var body: some View {
        HStack(alignment: .center) {
            CardView(model: model.characters[0], index: 0)
            CardView(model: model.characters[1], index: 1)
            CardView(model: model.characters[2], index: 2)
        }
        .background(Color.captainCelticBlue)
        .padding()
        .cornerRadius(6)
    }
}

struct CardView: View {
    let model: Character
    let index: Int
    var body: some View {
        Link(destination: URL(string: "widget://character\(index)")!) {
            VStack(alignment: .center) {
                Image(uiImage: model.image ?? UIImage(named: "marvel_characters")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.primaryRed, lineWidth: 4))
                            .shadow(radius: 10)
                Text(model.name ?? "")
                    .font(.system(size: 12.0, weight: .heavy, design: .rounded))
                    .lineLimit(0)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding([.trailing], 15)
                    .foregroundColor(Color.white)
            }
        }
    }
    
}

