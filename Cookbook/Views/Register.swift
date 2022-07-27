//
//  Register.swift
//  Cookbook
//
//  Created by Alex on 2022-07-27.
//

import SwiftUI

struct Register: View {
    @ObservedObject var viewRouter: ViewRouter
    
    private struct DrawingConstants{
        static let backButtonIconFrameWidth: CGFloat = 20
        static let backButtonIconFrameHeight: CGFloat = 30
        static let backButtonPaddingButtom: CGFloat = 700
        static let backButtonPaddingTrailing: CGFloat = 330
        static let textFont: CGFloat = 33
        static let textPaddingBottom: CGFloat = 530
        static let rectangleCornerRadius: CGFloat = 15
        static let rectangleShadow: CGFloat = 5
        static let VStackSpacing: CGFloat = 20
        static let ZStackPaddingHorizontal: CGFloat = 37
        static let ZstackPaddingVertical: CGFloat = 180
    }
    
    
    
    var body: some View {
        ZStack{
            TopPart(viewRouter: viewRouter)
           CenterRectangle()
            .padding(.horizontal, DrawingConstants.ZStackPaddingHorizontal)
            .padding(.vertical, DrawingConstants.ZstackPaddingVertical)
            
        }
        .background(Image("LoginRegisterBackground"))
    }
    
    // MARK: - Top part of the register view
    
    struct TopPart: View {
        @ObservedObject var viewRouter: ViewRouter
        var body: some View {
            Button(
                action: {viewRouter.page = .Login}) {
                    Image(systemName: "chevron.left")
                        .resizable(resizingMode: .stretch)
                        .foregroundColor(.gray)
                        .frame(
                            width: DrawingConstants.backButtonIconFrameWidth,
                            height: DrawingConstants.backButtonIconFrameHeight)
                }
                .padding(.bottom, DrawingConstants.backButtonPaddingButtom)
                .padding(.trailing, DrawingConstants.backButtonPaddingTrailing)
            Text("Register")
                .font(
                    .system(
                        size: DrawingConstants.textFont,
                        weight: .regular,
                        design: .default ))
                .padding(.bottom, DrawingConstants.textPaddingBottom)
        }
    }
    
    // MARK: - Center part of the register view
    
    struct CenterRectangle: View{
        @State private var email: String = ""
        @State private var username: String = ""
        @State private var password: String = ""
        @State private var passwordConfirm: String = ""
        
        var body: some View {
            ZStack{
                RoundedRectangle(cornerRadius: DrawingConstants.rectangleCornerRadius)
                    .fill(.white)
                    .shadow(radius: DrawingConstants.rectangleShadow)
                VStack(spacing: DrawingConstants.VStackSpacing){
                    TextField(
                        "Email",
                        text: $email)
                    .textFieldStyle(TextFieldDesign(image: "mail"))
                    TextField(
                        "Username",
                        text: $username)
                    .textFieldStyle(TextFieldDesign(image: "person"))
                    TextField(
                        "Password",
                        text: $password)
                    .textFieldStyle(TextFieldDesign(image: "key"))
                    TextField(
                        "Confirm Password",
                        text: $passwordConfirm)
                    .textFieldStyle(TextFieldDesign(image: "key"))
                    Button(
                        "Register",
                        action: {})
                    .buttonStyle(CustomButton())
                }
                .padding(.horizontal)
            }
        }
    }
}


















struct Register_Previews: PreviewProvider {
    static var previews: some View {
        let viewRouter = ViewRouter()
        Register(viewRouter: viewRouter)
    }
}
