//
//  SideMenu.swift
//  Cookbook
//
//  Created by Alex on 2022-07-28.
//

import SwiftUI

struct MenuItemsView: View {
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Text("Profile")
            }
            HStack {
                Text("Settings")
            }
            HStack {
                Text("Library")
            }
            HStack {
                Text("Favorites")
            }
            HStack {
                Text("Sign Out")
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.mustardYellow)
        .edgesIgnoringSafeArea(.all)
    }
}
