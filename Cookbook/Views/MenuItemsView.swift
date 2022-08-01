//
//  SideMenu.swift
//  Cookbook
//
//  Created by Alex on 2022-07-28.
//

import SwiftUI

struct MenuItemsView: View {
    
    private struct DrawingConstants {
        static let imageSize: CGFloat = 80
        static let imageHeight: CGFloat = 110
        static let imageWidth: CGFloat = 110
        static let itemsTopPadding: CGFloat = 30
        static let itemsLeadingPadding: CGFloat = 30
    }
    
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack {
            Image(systemName: "person.crop.circle")
                .font(.system(size: DrawingConstants.imageSize))
                .frame(
                    width: DrawingConstants.imageWidth,
                    height: DrawingConstants.imageHeight,
                    alignment: .center)
            VStack(alignment: .leading){
                Divider()
                HStack {
                    Image(systemName: "person.fill")
                        .imageScale(.large)
                    Text("My profile")
                        .font(.headline)
                }
                .padding(.top, DrawingConstants.itemsTopPadding)
                HStack {
                    Image(systemName: "bookmark")
                        .imageScale(.large)
                    Text("Saved")
                        .font(.headline)
                }
                .padding(.top, DrawingConstants.itemsTopPadding)
                HStack {
                    Image(systemName: "gearshape")
                        .imageScale(.large)
                    Text("Settings")
                        .font(.headline)
                }
                .padding(.top, DrawingConstants.itemsTopPadding)
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
                .padding(.top, DrawingConstants.itemsTopPadding)
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, DrawingConstants.itemsLeadingPadding)
            //.background(Color.mustardYellow)
            //.edgesIgnoringSafeArea(.all)
        }
        .background(Color.mustardYellow)
    }
}
