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
        static let menuTopPadding: CGFloat = 40
        static let itemsTopPadding: CGFloat = 30
        static let itemsLeadingPadding: CGFloat = 40
        static let shadowColorOpacity: CGFloat = 0.3
        static let shadowRadius: CGFloat = 0.05
    }
    
    @Binding var showMenu: Bool
    @ObservedObject var recipe: RecipeViewModel
        
    var body: some View {
        VStack {
            Image(systemName: "person.crop.circle")
                .font(.system(size: DrawingConstants.imageSize))
                .frame(
                    width: DrawingConstants.imageWidth,
                    height: DrawingConstants.imageHeight,
                    alignment: .center)
                .foregroundColor(.white)
            VStack(alignment: .leading){
                Divider()
                HStack {
                    Image(systemName: "person.fill")
                        .imageScale(.large)
                    Text("My profile")
                        .font(.custom("Welland Semibold",
                                      size: 17))
                        .onTapGesture {
                            print(recipe.recipes)
                        }
                }
                .padding(.top, DrawingConstants.itemsTopPadding)
                
            
                NavigationLink(destination: {
                    AddingRecipeView()
                        .onAppear {
                            withAnimation(){
                                showMenu = false
                            }
                        }
                }, label: {
                    HStack {
                        Image(systemName: "plus")
                            .imageScale(.large)
                        Text("Add a new recipe")
                            .font(.custom("Welland Semibold",
                                          size: 17))
                    }
                })
                .padding(.top, DrawingConstants.itemsTopPadding)
                HStack {
                    Image(systemName: "bookmark")
                        .imageScale(.large)
                    Text("Saved")
                        .font(.custom("Welland Semibold",
                                      size: 17))
                }
                .padding(.top, DrawingConstants.itemsTopPadding)
                HStack {
                    Image(systemName: "gearshape")
                        .imageScale(.large)
                    Text("Settings")
                        .font(.custom("Welland Semibold",
                                      size: 17))
                }
                .padding(.top, DrawingConstants.itemsTopPadding)
                
                NavigationLink {
                    LoginView()
                } label: {
                    HStack {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .imageScale(.large)
                        Text("Sign Out")
                            .font(.custom("Welland Semibold",
                                          size: 17))
                    }
                }
                .padding(.top, DrawingConstants.itemsTopPadding)
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, DrawingConstants.itemsLeadingPadding)
            .foregroundColor(.white)
            //.background(Color.mustardYellow)
            //.edgesIgnoringSafeArea(.all)
        }
        .padding(.top, DrawingConstants.menuTopPadding)
        .background(Color.sageGreen)
        .innerShadow(
            color: .black.opacity(DrawingConstants.shadowColorOpacity),
            radius: DrawingConstants.shadowRadius)
    }
}
