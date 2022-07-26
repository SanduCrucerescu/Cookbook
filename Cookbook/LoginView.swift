//
//  Cookbook
//
//  Created by Alex on 2022-07-26.
//

import SwiftUI

struct LoginView: View {
    var firebaseViewModel: FirebaseViewModel
    @ObservedObject var viewRouter: ViewRouter
    @State private var email: String = "test@t.com"
    @State private var passoword: String = "test12"

    
    var body: some View {
        VStack {
            TextField(
                "Email",
                text: $email
            ).border(.black)
            TextField(
                "Password",
                text: $passoword
            ).border(.black)
            Button(
                "Login",
                action: {firebaseViewModel.logIn(email, passoword, viewRouter)}
            )
        }
        .padding(.horizontal)
    }
}









































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let firebase = FirebaseViewModel()
        let viewRouter = ViewRouter()
        LoginView(firebaseViewModel: firebase, viewRouter: viewRouter)
    }
}
