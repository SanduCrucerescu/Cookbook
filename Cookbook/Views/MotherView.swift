//
//  MotherView.swift
//  Cookbook
//
//  Created by Alex on 2022-07-26.
//

import SwiftUI

struct MotherView: View {
    @ObservedObject var viewRouter: ViewRouter
    let firebase = FirebaseViewModel()
    var body: some View {
        switch viewRouter.page {
            case .Login:
                LoginView(firebaseViewModel: firebase, viewRouter: viewRouter)
            case .MainPage:
                MainPage()
            case .Register:
                Register(viewRouter: viewRouter)
        }
    }
}
