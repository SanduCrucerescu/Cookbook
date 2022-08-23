//
//  UserPageView.swift
//  Cookbook
//
//  Created by Alex on 2022-08-22.
//

import SwiftUI


struct UserPostSubMenu: View {
    @Binding var height: CGFloat
    @State var viewHeight: CGFloat = 0
    
    var body: some View{
        VStack{
            ForEach(0..<50, id: \.self) {_ in
                Text("Posts")
            }
        }
        .background(
            GeometryReader { geo in
                Color.clear
                    .preference(key: HeightPreferenceKey.self,
                                value: geo.size.height)
            } .onPreferenceChange(HeightPreferenceKey.self, perform: { height in
                self.height = height
                self.viewHeight = height
            }))
        .onAppear {
            self.height = viewHeight
        }
        
    }
}

struct UserCommentsSubMenu: View {
    @Binding var height: CGFloat
    @State var viewHeight: CGFloat = 0
    
    var body: some View {
        VStack {
            ForEach(0..<25, id: \.self) { _ in
                Text("Comments")
            }
        }
        .background(
            GeometryReader { geo in
                Color.clear
                    .preference(key: HeightPreferenceKey.self,
                                value: geo.size.height)
            } .onPreferenceChange(HeightPreferenceKey.self, perform: { height in
                self.height = height
                self.viewHeight = height
            }))
        .onAppear {
            self.height = viewHeight
        }
    }
}

struct UserPageView: View {
    @State var index: CGFloat = 0
    @EnvironmentObject var firebase: FirebaseViewModel
    
    var body: some View {
        GeometryReader { geo in
            //ZStack {
               ScrollView(showsIndicators: false) {
                   Image("ThumbnailPhoto")
                        .resizable()
                        .aspectRatio(CGSize(width: 1, height: 0.3),contentMode: .fit)
                       
                    // Contents
                   VStack {
                       HStack {
                           Image(uiImage: firebase.user.imageURL!)//systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 100, height: 100)
                            //.clipShape(Circle())
                            .overlay(Circle().strokeBorder(Color.backgroundColor, lineWidth: 7) )
                            .padding(10)
                           Spacer()
                           Button {
                               
                           } label: {
                               Text("Edit")
                           }
                           .padding(.vertical, 4)
                           .padding(.horizontal)
                           .background(
                                Capsule()
                                    .stroke(Color.sageGreen, lineWidth: 1.5))
                           .padding(.top, 40)
                           .padding(.trailing,20)
                           

                       }
                       .padding(.top, -50)
                       
                       VStack(alignment: .leading) {
                            Spacer()
                            Text(firebase.user.username)
                                .font(.custom("ProximaNova-Regular",
                                              size: 30))
                                .foregroundColor(.textColor)
                            Text(firebase.user.description)
                                .font(.custom("ProximaNova-Regular",
                                              size: 15))
                                .foregroundColor(.textColor)
                            HStack{
                                Button {
                                    
                                } label: {
                                    Text("Posts")
                                        .font(.custom("ProximaNova-Regular",
                                                      size: 20))
                                        .foregroundColor(.textColor)
                                }
                                .frame(maxWidth: .infinity)
                                
                                Divider()
                                    .frame(height: 30)
                                
                                Button {
                                    print(index)
                                } label: {
                                    Text("Comments")
                                        .font(.custom("ProximaNova-Regular",
                                                      size: 20))
                                        .foregroundColor(.textColor)
                                }
                                .frame(maxWidth: .infinity)
                            }
                            Divider()
                            
                            TabView {
                                UserPostSubMenu(height: $index)
                                UserCommentsSubMenu(height: $index)

                            }
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                            .frame(height: index)
                        }
                        .padding()
                        
                        .cornerRadius(10)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .offset(y: -30.0)
                   }
                  // .background(Color.green)
                    
                    
//                        Image(systemName: "person.crop.circle")
//                            .font(.system(size: 100))
//                            .offset(y: -700.0)
                    
                }
               .background(Color.backgroundColor)
            //}
            .navigationBarTitle(Text(""),
                                displayMode: .inline)
            .edgesIgnoringSafeArea(.vertical)
            .onAppear {
                index = geo.size.height
            }
        }
    }
}






struct UserPageView_Previews: PreviewProvider {
    static var previews: some View {
        let recipe = RecipeViewModel()
        let firebase = FirebaseViewModel(recipeViewModel: recipe)
        UserPageView()
            //.environmentObject(firebase)

    }
}
