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
            ZStack {
               ScrollView(showsIndicators: false) {
                   
                   ZStack {
                       Image("ThumbnailPhoto")
                            .resizable()
                            .aspectRatio(CGSize(width: 2, height: 1.4),contentMode: .fit)
                        .ignoresSafeArea(.all, edges: .top)
                       Image(uiImage: firebase.user.imageURL!)//systemName: "person.crop.circle")
                           .resizable()
                           .frame(width: 200, height: 210, alignment: .center)
//                           .font(.system(size: 150))
                           
                          // .offset(y: 45.0)
                   }
                    // Contents
                    
                    VStack {
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
                    .background(Color.backgroundColor)
                    .cornerRadius(10)
                    
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .offset(y: -20.0)
                    
                    
//                        Image(systemName: "person.crop.circle")
//                            .font(.system(size: 100))
//                            .offset(y: -700.0)
                    
                }
            }
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
        UserPageView()
    }
}
