//
//  SideMenu.swift
//  Cookbook
//
//  Created by Alex on 2022-07-28.
//

import SwiftUI

struct SideMenu: View {
    let width: CGFloat
    let menuOpen: Bool
    let toggleMenu: () -> Void
    
    var body: some View {
        ZStack {
            GeometryReader{ _ in
                EmptyView()
            }
            .background(.red.opacity(0.01))
            .opacity(self.menuOpen ? 1 : 0)
            .animation(.easeIn.delay(0.25), value: self.menuOpen)
            .onTapGesture {
                self.toggleMenu()
            }
            
            
            HStack{
                MenuItems()
                    .frame(width: width)
                    .offset(x: menuOpen ? 0 : -width)
                    .animation(.default, value: self.menuOpen)
                Spacer()
            }
        }
    }
}
