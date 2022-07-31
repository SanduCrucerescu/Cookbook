//
//  TopBar.swift
//  Cookbook
//
//  Created by Alex on 2022-07-31.
//

import SwiftUI

struct TopBar: View {
    @Binding var showMenu: Bool
    @State private var search: String = ""
    
    var body: some View {
        HStack {
            Image(systemName: "line.horizontal.3")
                .font(.system(size: 30))
                .onTapGesture {
                    withAnimation{
                        self.showMenu.toggle()
                    }
                }
            
            TextField(
                "Search",
                text: $search)
            .textFieldStyle(TextFieldDesign(image: "magnifyingglass", error: false))
            .padding(.trailing, 14)
        }.frame(alignment: .top)
    }
}

struct TopBar_Previews: PreviewProvider {
    static var previews: some View {
        TopBar(showMenu: .constant(false))
    }
}
