//
//  Cookbook
//
//  Created by Alex on 2022-07-26.
//

import SwiftUI

  // MARK: - LoginView

struct LoginView: View {
    let height = UIScreen.main.bounds.height
    var width = UIScreen.main.bounds.width
    
    private struct DrawingConstants{
        static let rectangleCornerRadius: CGFloat = 15
        static let shadow: CGFloat = 10
        static let VStackSpacing: CGFloat = 28
        static let paddingAll: CGFloat = 37
        static let paddingVerical: CGFloat = 4.8
        static let fontSize: CGFloat = 33
       // static let upperTextPadding: CGFloat = 400
        static let bottomTextFont: CGFloat = 15
       // static let bottomTextPadding: CGFloat = 350
        static let screenSize: CGFloat = 700
        static let centerWidthMultiplier: CGFloat = 0.8
        static let centerHeightIphone8: CGFloat = 290
        static let centerHeightIphone13: CGFloat = 280
        
    }
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center){
                Text("Sign In")
                    .font(.system(
                        size: DrawingConstants.fontSize,
                        weight: .regular,
                        design: .default))
                    //.padding(.bottom, DrawingConstants.upperTextPadding)
                    .foregroundColor(.granola)
               // Spacer()
                CenterSquare()
                    .frame(
                        width: width * DrawingConstants.centerWidthMultiplier,
                        height: height < DrawingConstants.screenSize
                                        ? DrawingConstants.centerHeightIphone8
                                        : DrawingConstants.centerHeightIphone13)
               // Spacer()
                BottomText()
                   // .padding(.top, DrawingConstants.bottomTextPadding)
            }
            .frame( maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("LoginRegisterBackground").renderingMode(.original))
            .navigationBarHidden(true)
            
        }
    }
    
    // MARK: - Center square
    
    struct CenterSquare: View {
        @EnvironmentObject var firebaseViewModel: FirebaseViewModel
        @EnvironmentObject var viewRouter: ViewRouter
        @State private var email: String = "test@t.com"
        @State private var passoword: String = "test12"
        @State private var isLogedI: Bool = false
        
        
        var body: some View {
            ZStack(alignment: .center){
                RoundedRectangle(cornerRadius: DrawingConstants.rectangleCornerRadius)
                    .fill(.white)
                    .shadow(radius: DrawingConstants.shadow)
                VStack {
//                    if !firebaseViewModel.isLogedIn {
//                        Text("Email or password incorect. Try again")
//                            .foregroundColor(.red)
//                    }
                    VStack(spacing: DrawingConstants.VStackSpacing) {
                        TextField(
                            "Email",
                            text: $email)
                        .textFieldStyle(
                            TextFieldDesign(
                                image: "mail",
                                error: !firebaseViewModel.isLogedIn))
                        TextField(
                            "Password",
                            text: $passoword)
                        .textFieldStyle(
                            TextFieldDesign(
                                image: "key",
                                error: !firebaseViewModel.isLogedIn))
//                        NavigationLink().onTapGesture {
//                            firebaseViewModel.signIn(email, passoword, viewRouter)
//                        } {
////                            firebaseViewModel.signIn(email, passoword, viewRouter)
//                            if firebaseViewModel.isLogedIn {
//                                MainPage()
//                                    .environmentObject(firebaseViewModel.recipeViewModel)
//                            }
//                        }
//                        .buttonStyle(CustomButton(color: .granola))
//                        NavigationLink(destination: {
//                            //if firebaseViewModel.isLogedIn {
//                                MainPage()
//                                    .environmentObject(firebaseViewModel.recipeViewModel)
//                            //}
                        
//                        NavigationLink(isActive: $isLogedI) {
//                            MainPage()
//                                .environmentObject(firebaseViewModel.recipeViewModel)
//                        } label: {
//                            Text("v")
//                        }
//
//
//                        Button {
//                            firebaseViewModel.signIn(email, passoword, viewRouter)
//                            print("gggg \(firebaseViewModel.isLogedIn)")
//                            if firebaseViewModel.isLogedIn {
//                                self.isLogedI = true
//                                print("1")
//                            }
//                        } label: {
//                            Text("Sign In")
//                        }
//
                        NavigationLink(destination: Text("aaa") , isActive: $isLogedI, label: {
                                        Button(action: {
                                            Task{
                                                await firebaseViewModel.signIn(email, passoword, viewRouter)
                                            }
                                            isLogedI = firebaseViewModel.isLogedIn
                                            print(isLogedI)
                                        }, label: {
                                            Text("Sign In")
                                        })
                        })

//
//
//                        }, label: {
//                            Text("login")
//                        }).onTapGesture {
//                            firebaseViewModel.signIn(email, passoword, viewRouter)
//                        }
                        }
                    .padding(.horizontal)
                }
            }
        }
    }
    
    // MARK: - Bottom Text
    
    struct BottomText: View {
        @EnvironmentObject var viewRouter: ViewRouter
        
        var body: some View {
            HStack{
                Text("Don't have an account!")
                        .font(
                            .system(
                                size: DrawingConstants.bottomTextFont,
                                weight: .light,
                                design: .default))
                
                
                NavigationLink{
                    Register()
                } label: {
                    Text("Register now")
                        .underline()
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

}
















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let recipe = RecipeViewModel()
        let firebase = FirebaseViewModel(recipeViewModel: recipe)
        let viewRouter = ViewRouter()
        Group {
            LoginView()
                .environmentObject(viewRouter)
                .environmentObject(firebase)
        }
    }
}
