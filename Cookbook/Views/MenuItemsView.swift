//
//  SideMenu.swift
//  Cookbook
//
//  Created by Alex on 2022-07-28.
//

import SwiftUI

struct MenuItemsView: View {
    @ObservedObject var viewRouter: ViewRouter
    var body: some View {
        VStack {
            Image(systemName: "person.crop.circle")
                .font(.system(size: 80))
                .frame(width: 110, height: 110, alignment: .center)
            VStack(alignment: .leading){
    //            Circle()
    //                .fill("person")
    //                .padding(.top, 10)
    //                .frame(width: 110, height: 110, alignment: .center
                    //.overlay(Circle().stroke(lineWidth: 3))
                Divider()
                HStack {
                    Image(systemName: "person.fill")
                        .imageScale(.large)
                    Text("My profile")
                        .font(.headline)
                }
                .padding(.top, 30)
                HStack {
                    Image(systemName: "bookmark")
                        .imageScale(.large)
                    Text("Saved")
                        .font(.headline)
                }
                .padding(.top, 30)
                HStack {
                    Image(systemName: "gearshape")
                        .imageScale(.large)
                    Text("Settings")
                        .font(.headline)
                }
                .padding(.top, 30)
                HStack {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .imageScale(.large)
                    Text("Sign Out")
                        .onTapGesture {
                            viewRouter.page = .Login
                            print("s")
                        }
                        .font(.headline)
                }
                .padding(.top, 30)
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 12)
            //.background(Color.mustardYellow)
            //.edgesIgnoringSafeArea(.all)
        }
        .background(Color.mustardYellow)
    }
}
