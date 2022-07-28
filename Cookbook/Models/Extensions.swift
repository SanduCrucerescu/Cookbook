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

//MARK: - struct for the password validation

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

//MARK: - struct for the login validation

struct LoginTextFiels: ViewModifier {
    let image: String
    @ObservedObject var firebaseViewModel: FirebaseViewModel
    
    func body(content: Content) -> some View {
        content
            .textFieldStyle(TextFieldDesign(image: image, error: !firebaseViewModel.isLogedIn))
            .modifier(ShakeEffect(shakes: !firebaseViewModel.isLogedIn ? 2 : 0))
            .animation(Animation.linear, value: !firebaseViewModel.isLogedIn)
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
            .animation(Animation.linear, value: !firebaseViewModel.isEmail)
    }
}




extension TextField {
    func passwordTextField(image: String, firebaseViewModel: FirebaseViewModel) -> some View {
        self.modifier(PasswordTextFiels(image: image, firebaseViewModel: firebaseViewModel))
    }
    
    func loginTextFields(image: String, firebaseViewModel: FirebaseViewModel) -> some View {
        self.modifier(LoginTextFiels(image: image, firebaseViewModel: firebaseViewModel))
    }
    
    func emailTextFields(image: String, firebaseViewModel: FirebaseViewModel) -> some View {
        self.modifier(EmailTextFiels(image: image, firebaseViewModel: firebaseViewModel))
    }
}

extension Color {
    static let mustardYellow = Color("MustartYellow")
}
