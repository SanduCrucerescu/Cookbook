//
//  Register.swift
//  Cookbook
//
//  Created by Alex on 2022-07-27.
//

import SwiftUI

struct Register: View {
    let height = UIScreen.main.bounds.height
    var width = UIScreen.main.bounds.width
    
    private struct DrawingConstants {
        static let backButtonIconFrameWidth: CGFloat = 20
        static let backButtonIconFrameHeight: CGFloat = 30
        static let backButtonHeightIphone8: CGFloat = 620
        static let backButtonHeightIphoneXS: CGFloat = 700
        static let backButtonPaddingButtom: CGFloat = 700
        static let backButtonPaddingTrailing: CGFloat = 330
        static let textFont: CGFloat = 33
        static let rectangleCornerRadius: CGFloat = 15
        static let rectangleShadow: CGFloat = 5
        static let VStackSpacing: CGFloat = 15
        static let centerRectangleWidthMltiplier: CGFloat = 0.8
        static let centerRectangleHeight: CGFloat = 450
        static let passwordInformation: CGFloat = 18

    }
    
    
    
    var body: some View {
        
        VStack{
            TopPart()
            CenterRectangle()
                .frame(
                    width: width * DrawingConstants.centerRectangleWidthMltiplier,
                    height: DrawingConstants.centerRectangleHeight)
                
        }
        //.ignoresSafeArea(.all)
        //.navigationBarHidden(true)
        .navigationBarTitle(Text(""), displayMode: .inline)
        .background(Image("LoginRegisterBackground"))
    }
    
    // MARK: - Top part of the register view
    
    struct TopPart: View {
        var body: some View {
            Text("Register")
                .font(.custom("Welland",
                              size: DrawingConstants.textFont))
                .foregroundColor(.white)
        }
    }
    
    // MARK: - Center part of the register view
    
    struct CenterRectangle: View{
        @State private var email: String = ""
        @State private var username: String = ""
        @State private var password1: String = ""
        @State private var password2: String = ""
        @EnvironmentObject var firebaseViewModel: FirebaseViewModel
        
        var body: some View {
            ZStack{
                RoundedRectangle(cornerRadius: DrawingConstants.rectangleCornerRadius)
                    .fill(.white)
                    .shadow(radius: DrawingConstants.rectangleShadow)
                VStack{
                    if !firebaseViewModel.isEmail {
                        Text("Not a valid email address")
                            .font(.custom("ProximaNova-Regular",
                                          size: DrawingConstants.passwordInformation))
                            .foregroundColor(.red)
                    }
                    VStack(spacing: DrawingConstants.VStackSpacing) {
                        Group {
                            TextField(
                                "Email",
                                text: $email)
                            .textFieldStyle(
                                TextFieldDesign(
                                    image: "mail",
                                    error: !firebaseViewModel.isEmail,
                                    shadow: true))
                            TextField(
                                "Username",
                                text: $username)
                            .textFieldStyle(
                                TextFieldDesign(
                                    image: "person",
                                    error: false,
                                    shadow: true))
                            Text("The password needs to be at least 6 characters long")
                                .font(.custom("ProximaNova-Regular",
                                              size: DrawingConstants.passwordInformation))
                                .foregroundColor(.textColor)
                        }
                    }
                        .padding(.horizontal)
                    if firebaseViewModel.passwordsAreNotEqual {
                        Text("Passwords are not equal")
                            .foregroundColor(.red)
                    }
                    VStack(spacing: DrawingConstants.VStackSpacing){
                        Group {
                            TextField(
                                "Password",
                                text: $password1)
                                .textFieldStyle(
                                    TextFieldDesign(
                                        image: "key",
                                        error: firebaseViewModel.passwordsAreNotEqual,
                                        shadow: true))
                            TextField(
                                "Confirm Password",
                                text: $password2)
                                .textFieldStyle(
                                    TextFieldDesign(
                                        image: "key",
                                        error: firebaseViewModel.passwordsAreNotEqual,
                                        shadow: true))
                            Button(
                                "Register",
                                action: {firebaseViewModel.register(email, password1, password2, username)})
                            .buttonStyle(CustomButton(color: .white))
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}


















struct Register_Previews: PreviewProvider {
    static var previews: some View {
        let recipe = RecipeViewModel()
        let firebaseViewModel = FirebaseViewModel(recipeViewModel: recipe)
        Register()
            .environmentObject(firebaseViewModel)
    }
}
