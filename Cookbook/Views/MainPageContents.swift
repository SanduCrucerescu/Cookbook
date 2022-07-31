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
        VStack {
            TopBar(showMenu: $showMenu)
            Spacer()
        }
    }
}



struct MainPageContents_Previews: PreviewProvider {
    static var previews: some View {
        MainPageContents(showMenu: .constant(false))
    }
}
