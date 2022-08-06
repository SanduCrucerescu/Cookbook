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
        static let bottomTextFont: CGFloat = 15
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
                    .foregroundColor(.granola)
                CenterSquare()
                    .frame(
                        width: width * DrawingConstants.centerWidthMultiplier,
                        height: height < DrawingConstants.screenSize
                                        ? DrawingConstants.centerHeightIphone8
                                        : DrawingConstants.centerHeightIphone13)
                BottomText()
            }
            .frame( maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("LoginRegisterBackground").renderingMode(.original))
            .navigationBarHidden(true)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    // MARK: - Center square
    
    struct CenterSquare: View {
        @EnvironmentObject var firebaseViewModel: FirebaseViewModel
        @State private var email: String = "test@t.com"
        @State private var passoword: String = "test12"
        @State private var isLogedI: Bool = false
        
        
        var body: some View {
            ZStack(alignment: .center){
                RoundedRectangle(cornerRadius: DrawingConstants.rectangleCornerRadius)
                    .fill(Color.backgroundColor)
                    .shadow(radius: DrawingConstants.shadow)
                VStack {
                    if !(firebaseViewModel.isLogedIn ?? true) {
                        Text("Email or password incorect. Try again")
                            .foregroundColor(.red)
                    }
                    VStack(spacing: DrawingConstants.VStackSpacing) {
                        TextField(
                            "Email",
                            text: $email)
                        .textFieldStyle(
                            TextFieldDesign(
                                image: "mail",
                                error: !(firebaseViewModel.isLogedIn ?? true)))
                        TextField(
                            "Password",
                            text: $passoword)
                        .textFieldStyle(
                            TextFieldDesign(
                                image: "key",
                                error: !(firebaseViewModel.isLogedIn ?? true)))
                        NavigationLink(destination: MainPage().environmentObject(firebaseViewModel.recipeViewModel) , isActive: $isLogedI, label: {
                                        Button(action: {
                                            Task{
                                                await firebaseViewModel.signIn(email, passoword)
                                                isLogedI = firebaseViewModel.isLogedIn ?? false
                                                print(isLogedI)
                                            }
                                          print(isLogedI)
                                        }, label: {
                                            Text("Sign In")
                                        }) .buttonStyle(CustomButton(color: .granola))
                        })
                        }
                    .padding(.horizontal)
                }
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
        Group {
            LoginView()
                .environmentObject(firebase)
        }
    }
}
