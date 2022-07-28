//
//  Extensions.swift
//  Cookbook
//
//  Created by Alex on 2022-07-26.
//

import SwiftUI

// MARK: - The textfield shake effect

struct ShakeEffect: GeometryEffect {
       func effectValue(size: CGSize) -> ProjectionTransform {
           return ProjectionTransform(CGAffineTransform(translationX: -20 * sin(position * 2 * .pi), y: 0))
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

//MARK: - struct for the password validation

struct PasswordTextFiels: ViewModifier {
    let image: String
    @ObservedObject var firebaseViewModel: FirebaseViewModel
    
    func body(content: Content) -> some View {
        content
            .textFieldStyle(TextFieldDesign(image: image, error: firebaseViewModel.areEqual))
            .modifier(ShakeEffect(shakes: firebaseViewModel.areEqual ? 2 : 0))
            .animation(Animation.linear.repeatCount(3).speed(5), value: firebaseViewModel.areEqual)
    }
}

//MARK: - struct for the email validation

struct EmailTextFiels: ViewModifier {
    let image: String
    @ObservedObject var firebaseViewModel: FirebaseViewModel
    
    func body(content: Content) -> some View {
        content
            .textFieldStyle(TextFieldDesign(image: image, error: !firebaseViewModel.isEmail))
            .modifier(ShakeEffect(shakes: !firebaseViewModel.isEmail ? 2 : 0))
            .animation(Animation.linear.repeatCount(3).speed(5), value: !firebaseViewModel.isEmail)
    }
}





extension TextField {
    func passwordTextField(image: String, firebaseViewModel: FirebaseViewModel) -> some View {
        self.modifier(PasswordTextFiels(image: image, firebaseViewModel: firebaseViewModel))
    }
    
    func emailTextField(image: String, firebaseViewModel: FirebaseViewModel) -> some View {
        self.modifier(EmailTextFiels(image: image, firebaseViewModel: firebaseViewModel))
    }
}

extension Color {
    static let mustardYellow = Color("MustartYellow")
}
