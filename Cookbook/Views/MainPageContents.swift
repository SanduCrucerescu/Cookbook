//
//  MainPageContents.swift
//  Cookbook
//
//  Created by Alex on 2022-07-30.
//

import SwiftUI

struct MainPageContents: View {
    @Binding var showMenu: Bool
    
    var body: some View {
        Button(
            action: {
                withAnimation{
                    self.showMenu = true
                }
            }){
            Text("Show Menu")
        }
    }
}



struct MainPageContents_Previews: PreviewProvider {
    static var previews: some View {
        MainPageContents(showMenu: .constant(false))
    }
}
