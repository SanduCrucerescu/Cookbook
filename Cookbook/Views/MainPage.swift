//
//  MainPage.swift
//  Cookbook
//
//  Created by Alex on 2022-07-26.
//

import SwiftUI

struct MainPage: View {
    
    @State var menuOpen: Bool = false
    
    var body: some View {
        ZStack {
            Button(
                action: {
                    self.menuOpen.toggle()
                },
                label: {Text("Open menu")}
            ).background(.gray)
            SideMenu(
                width: UIScreen.main.bounds.width/2,
                menuOpen:menuOpen,
                toggleMenu: toggleMenu)
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    func toggleMenu() {
        menuOpen.toggle()
    }
    
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
