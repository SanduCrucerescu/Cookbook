//
//  MainPageContents.swift
//  Cookbook
//
//  Created by Alex on 2022-07-30.
//

import SwiftUI

struct MainPage: View {
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack {
            Text("MainView")
        }
            .contentView(viewRouter: viewRouter)
    }
}



struct MainPageContents_Previews: PreviewProvider {
    static var previews: some View {
        let viewRouter = ViewRouter()
        MainPage(viewRouter: viewRouter)
    }
}
