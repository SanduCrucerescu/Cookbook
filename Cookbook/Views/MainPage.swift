//
//  MainPage.swift
//  Cookbook
//
//  Created by Alex on 2022-07-26.
//

import SwiftUI


struct MainPage: View {
    @State var showMenu = false
    @ObservedObject var viewRouter: ViewRouter
    var body: some View {
        let drag = DragGesture()
            .onEnded{
                if $0.translation.width < -100 {
                    withAnimation() {
                        showMenu = false
                    }
                }
            }
        
        GeometryReader{ geo in
            ZStack(alignment: .leading) {
                MainPageContents(showMenu: $showMenu)
                    .frame(width: geo.size.width, height: geo.size.height)
                    .offset(x: self.showMenu ? geo.size.width/2 : 0)
                    //.disabled(self.showMenu ? true : false)
                    
    
                if self.showMenu {
                    MenuItemsView(viewRouter: viewRouter)
                        .frame(width: geo.size.width/2)
                        .transition(.move(edge: .leading))
                }
            }
            .gesture(drag)
        }
    }
}









struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        let viewRouter = ViewRouter()
        MainPage(viewRouter: viewRouter)
    }
}
