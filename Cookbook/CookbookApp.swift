//
//  CookbookApp.swift
//  Cookbook
//
//  Created by Alex on 2022-07-26.
//

import SwiftUI
import Firebase

@main
struct CookbookApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            let firebase = FirebaseViewModel()
            LoginView(firebaseViewModel: firebase)
        }
    }
}
