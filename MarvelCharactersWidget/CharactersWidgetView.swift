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
        VStack(alignment: .leading) {
            Text(model.first ?? "")
                .font(.custom("Bitter-Bold", size: 19.0))
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
                .padding([.trailing], 15)
                .foregroundColor(Color.gray)
            Text(model.second ?? "")
                .font(.custom("Bitter-Bold", size: 19.0))
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
                .padding([.trailing], 15)
                .foregroundColor(Color.gray)
            Text(model.third ?? "")
                .font(.custom("Bitter-Bold", size: 19.0))
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
                .padding([.trailing], 15)
                .foregroundColor(Color.gray)
        }
        .background(Color("cardBackground"))
        .padding()
        .cornerRadius(6)
    }
}
