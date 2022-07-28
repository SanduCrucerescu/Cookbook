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
    let height = UIScreen.main.bounds.height
    var width = UIScreen.main.bounds.width
    
    private struct DrawingConstants{
        static let rectangleCornerRadius: CGFloat = 15
        static let shadow: CGFloat = 10
        static let VStackSpacing: CGFloat = 28
        static let paddingAll: CGFloat = 37
        static let paddingVerical: CGFloat = 4.8
        static let fontSize: CGFloat = 33
        static let upperTextPadding: CGFloat = 400
        static let bottomTextFont: CGFloat = 15
        static let bottomTextPadding: CGFloat = 350
        static let screenSize: CGFloat = 700
        static let centerWidthMultiplier: CGFloat = 0.8
        static let centerHeightIphone8: CGFloat = 290
        static let centerHeightIphone13: CGFloat = 280
        
    }
    
    var body: some View {
            ZStack{
                Text("Sign In")
                    .font(.system(
                        size: DrawingConstants.fontSize,
                        weight: .regular,
                        design: .default))
                    .padding(.bottom, DrawingConstants.upperTextPadding)
                Spacer()
                CenterSquare(firebaseViewModel: firebaseViewModel, viewRouter: viewRouter)
                    .frame(
                        width: width * DrawingConstants.centerWidthMultiplier,
                        height: height < DrawingConstants.screenSize
                                        ? DrawingConstants.centerHeightIphone8
                                        : DrawingConstants.centerHeightIphone13)
                Spacer()
                BottomText(viewRouter: viewRouter)
                    .padding(.top, DrawingConstants.bottomTextPadding)
            }.frame( maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("LoginRegisterBackground").renderingMode(.original))
    }
    
    // MARK: - Center square
    
    struct CenterSquare: View {
        @ObservedObject var firebaseViewModel: FirebaseViewModel
        @ObservedObject var viewRouter: ViewRouter
        @State private var email: String = "test@t.com"
        @State private var passoword: String = "test12"
        
        var body: some View {
            ZStack(alignment: .center){
                RoundedRectangle(cornerRadius: DrawingConstants.rectangleCornerRadius)
                    .fill(.white)
                    .shadow(radius: DrawingConstants.shadow)
                VStack {
                    if !firebaseViewModel.isLogedIn {
                        Text("Email or password incorect. Try again")
                            .foregroundColor(.red)
                    }
                    VStack(spacing: DrawingConstants.VStackSpacing) {
                        TextField(
                            "Email",
                            text: $email)
                            .textFieldStyle(TextFieldDesign(image: "mail", error: !firebaseViewModel.isLogedIn))
                        TextField(
                            "Password",
                            text: $passoword)
                            .textFieldStyle(TextFieldDesign(image: "key", error: !firebaseViewModel.isLogedIn))
                        Button(
                            "Login",
                            action: {firebaseViewModel.signIn(email, passoword, viewRouter)})
                            .buttonStyle(CustomButton())
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
    
    // MARK: - Bottom Text
    
    struct BottomText: View {
        @ObservedObject var viewRouter: ViewRouter
        
        var body: some View {
            HStack{
                Text("Don't have an account!")
                        .font(
                            .system(
                                size: DrawingConstants.bottomTextFont,
                                weight: .light,
                                design: .default))
                    
                Button(
                    action: {
                        viewRouter.page = .Register})
                        {Text("Register Now")
                            .underline()}
                        .font(
                            .system(
                                size: DrawingConstants.bottomTextFont,
                                weight: .semibold,
                                design: .default))
                        .foregroundColor(.black)
            }
        }
    }

}










































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let firebase = FirebaseViewModel()
        let viewRouter = ViewRouter()
        Group {
            LoginView(firebaseViewModel: firebase, viewRouter: viewRouter)
            LoginView(firebaseViewModel: firebase, viewRouter: viewRouter)
        }
    }
}
