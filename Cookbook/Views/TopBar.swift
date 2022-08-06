//
//  TopBar.swift
//  Cookbook
//
//  Created by Alex on 2022-07-31.
//

import SwiftUI

struct TopBar: View {
    
    private struct DrawingConstansts{
        static let imageSize: CGFloat = 22
        static let imageLeadingPadding: CGFloat = 5
        static let textFieldTrailingPadding: CGFloat = 14
    }
    
    @Binding var showMenu: Bool
    @State private var search: String = ""
    
    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            Button {
                withAnimation{
                    self.showMenu.toggle()
                }
            } label: {
                Image("Menu")
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10.0)
            }
            Spacer()
            
//            Image(systemName: "line.horizontal.3")
//                .font(.system(size: DrawingConstansts.imageSize))
//                .foregroundColor(.granola)
//                .onTapGesture {
//                    print(self.showMenu)
//                    withAnimation{
//                        self.showMenu.toggle()
//                    }
//                }
//                .padding(.leading, DrawingConstansts.imageLeadingPadding)
            
//            TextField(
//                "Search",
//                text: $search)
//            .textFieldStyle(TextFieldDesign(image: "magnifyingglass", error: false))
//            .padding(.trailing, DrawingConstansts.textFieldTrailingPadding)
        }
        .padding(.horizontal)
    }
}

struct TopBar_Previews: PreviewProvider {
    static var previews: some View {
        TopBar(showMenu: .constant(false))
    }
}
