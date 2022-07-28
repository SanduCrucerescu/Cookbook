//
//  MenuItems.swift
//  Cookbook
//
//  Created by Alex on 2022-07-28.
//

import SwiftUI

struct MenuItem: Identifiable {
    var id = UUID()
    let text: String
    let handeler: () ->Void
}


struct MenuItems: View {
    let items: [MenuItem] = [
        MenuItem(text: "Home", handeler: {}),
        MenuItem(text: "Search", handeler: {}),
        MenuItem(text: "Library", handeler: {}),
        MenuItem(text: "Sign Out", handeler: {})

    ]
    
    var body: some View {
        ZStack {
            Color(UIColor(Color.mustardYellow))
            
            VStack(alignment: .leading, spacing: 0) {
                ForEach(items){ item in
                    HStack {
                        Text(item.text)
                            .bold()
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    .onTapGesture {
                        item.handeler()
                    }
                    .padding()
                }
                Spacer()
            }
            .padding(.vertical, 70)
        }
    }
}

