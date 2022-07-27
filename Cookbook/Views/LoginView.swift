//
//  Cookbook
//
//  Created by Alex on 2022-07-26.
//

import SwiftUI

  // MARK: - LoginView

struct LoginView: View {
    var firebaseViewModel: FirebaseViewModel
    @ObservedObject var viewRouter: ViewRouter

    private struct DrawingConstants{
        static let rectangleCornerRadius: CGFloat = 15
        static let shadow: CGFloat = 10
        static let VStackSpacing: CGFloat = 38
        static let paddingAll: CGFloat = 37
        static let paddingVerical: CGFloat = 190
        static let fontSize: CGFloat = 33
        static let upperTextPadding: CGFloat = 400
        static let bottomTextFont: CGFloat = 15
        static let bottomTextPadding: CGFloat = 350
    }
    
    var body: some View {
        ZStack{
            Text("Login")
                .font(.system(size: DrawingConstants.fontSize, weight: .regular, design: .default))
                .padding(.bottom, DrawingConstants.upperTextPadding)
            CenterSquare(firebaseViewModel: firebaseViewModel, viewRouter: viewRouter)
                .padding(.all, DrawingConstants.paddingAll)
                .padding(.vertical, DrawingConstants.paddingVerical)
            BottomText()
                .padding(.top, DrawingConstants.bottomTextPadding)
        }
           // TODO: Adding background
    }
    
    // MARK: - Center square
    
    struct CenterSquare: View {
        var firebaseViewModel: FirebaseViewModel
        @ObservedObject var viewRouter: ViewRouter
        @State private var email: String = "test@t.com"
        @State private var passoword: String = "test12"
        
        var body: some View {
            ZStack{
                RoundedRectangle(cornerRadius: DrawingConstants.rectangleCornerRadius)
                    .fill(.white)
                    .shadow(radius: DrawingConstants.shadow)
                VStack(spacing: DrawingConstants.VStackSpacing) {
                    TextField(
                        "Email",
                        text: $email
                    ).textFieldStyle(TextFieldDesign(image: "mail"))
                    TextField(
                        "Password",
                        text: $passoword
                    ).textFieldStyle(TextFieldDesign(image: "key"))
                    Button(
                        "Login",
                        action: {firebaseViewModel.logIn(email, passoword, viewRouter)}
                    )
                        .buttonStyle(CustomButton())
                }
                .padding(.horizontal)
            }
        }
    }
    
    // MARK: - Bottom Text
    
    struct BottomText: View {
        var body: some View {
            HStack{
                Text("Don't have an account!")
                        .font(
                            .system(
                                size: DrawingConstants.bottomTextFont,
                                weight: .light,
                                design: .default))
                    
                Button("Sign Up", action: {})
                        .font(
                            .system(
                                size: DrawingConstants.bottomTextFont,
                                weight: .semibold,
                                design: .default)) // TODO: add underline text
                        .foregroundColor(.black)
            }
        }
    }

}










































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let firebase = FirebaseViewModel()
        let viewRouter = ViewRouter()
        LoginView(firebaseViewModel: firebase, viewRouter: viewRouter)
    }
}
