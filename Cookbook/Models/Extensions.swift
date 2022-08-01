//
//  Extensions.swift
//  Cookbook
//
//  Created by Alex on 2022-07-26.
//

import SwiftUI

// Played around with a shake effect for the textfields incase the information was wrong
// But it didn't work as I liked so I'm just storing it here, it is not used anyware

struct ShakeEffect: GeometryEffect {
       func effectValue(size: CGSize) -> ProjectionTransform {
           return ProjectionTransform(CGAffineTransform(translationX: -10 * sin(position * 2 * .pi), y: 0))
       }
       
       init(shakes: Int) {
           position = CGFloat(shakes)
       }
       
       var position: CGFloat
       var animatableData: CGFloat {
           get { position }
           set { position = newValue }
       }
   }

struct PasswordTextFiels: ViewModifier {
    let image: String
    @ObservedObject var firebaseViewModel: FirebaseViewModel
    
    func body(content: Content) -> some View {
        content
            .textFieldStyle(TextFieldDesign(image: image, error: firebaseViewModel.passwordsAreNotEqual))
            .modifier(ShakeEffect(shakes: !firebaseViewModel.passwordsAreNotEqual ? 2 : 0))
            .animation(Animation.linear, value: firebaseViewModel.passwordsAreNotEqual)
    }
}


//MARK: - Content view Extension

struct ContentView: ViewModifier {
    @State var showMenu = false
    @ObservedObject var viewRouter: ViewRouter
    
    func body(content: Content) -> some View {
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
                VStack {
                    TopBar(showMenu: $showMenu)
                    Spacer()
                    content
                    Spacer()
                }
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



//MARK: - Extensions

extension TextField {
//    func passwordTextField(image: String, firebaseViewModel: FirebaseViewModel) -> some View {
//        self.modifier(PasswordTextFiels(image: image, firebaseViewModel: firebaseViewModel))
//    }
//
//    func loginTextFields(image: String, firebaseViewModel: FirebaseViewModel) -> some View {
//        self.modifier(LoginTextFiels(image: image, firebaseViewModel: firebaseViewModel))
//    }
//
//    func emailTextFields(image: String, firebaseViewModel: FirebaseViewModel) -> some View {
//        self.modifier(EmailTextFiels(image: image, firebaseViewModel: firebaseViewModel))
//    }
}

extension Color {
    static let mustardYellow = Color("MustartYellow")
}


extension View {
    func contentView(viewRouter: ViewRouter) -> some View{
        self.modifier(ContentView(viewRouter: viewRouter))
    }
}
