//
//  ContentView.swift
//  Cookbook
//
//  Created by Alex on 2022-07-26.
//

import SwiftUI

struct LoginView: View {
    var firebaseViewModel: FirebaseViewModel
    @State private var email: String = ""
    @State private var passoword: String = ""
    var message: String = ""

    
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
                action: {firebaseViewModel.logIn(email, passoword)}//firebaseViewModel.logIn(email, passoword)
            )
        }
        .padding(.horizontal)
    }
}









































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let firebase = FirebaseViewModel()
        LoginView(firebaseViewModel: firebase)
    }
}
