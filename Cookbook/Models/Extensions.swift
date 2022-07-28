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
