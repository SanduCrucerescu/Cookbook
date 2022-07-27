//
//  MainPage.swift
//  Cookbook
//
//  Created by Alex on 2022-07-26.
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
            Color(UIColor(.green))
            
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



struct SideMenu: View {
    let width: CGFloat
    let menuOpen: Bool
    let toggleMenu: () -> Void
    
    var body: some View {
        ZStack {
            GeometryReader{ _ in
                EmptyView()
            }
            .background(.red.opacity(0.5))
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
