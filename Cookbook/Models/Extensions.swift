//
//  Extensions.swift
//  Cookbook
//
//  Created by Alex on 2022-07-26.
//

import SwiftUI

// Played around with a shake effect for the textfields incase the information was wrong
// But it didn't work as I liked so I'm just storing it here, it is not used anyware

struct ShakeEffect: GeometryEffect {
       func effectValue(size: CGSize) -> ProjectionTransform {
           return ProjectionTransform(CGAffineTransform(translationX: -10 * sin(position * 2 * .pi), y: 0))
       }
       
       init(shakes: Int) {
           position = CGFloat(shakes)
       }
       
       var position: CGFloat
       var animatableData: CGFloat {
           get { position }
           set { position = newValue }
       }
   }

struct PasswordTextFiels: ViewModifier {
    let image: String
    let shadow: Bool
    @ObservedObject var firebaseViewModel: FirebaseViewModel
    
    func body(content: Content) -> some View {
        content
            .textFieldStyle(
                TextFieldDesign(
                    image: image,
                    error: firebaseViewModel.passwordsAreNotEqual,
                    shadow: shadow))
            .modifier(ShakeEffect(shakes: !firebaseViewModel.passwordsAreNotEqual ? 2 : 0))
            .animation(Animation.linear, value: firebaseViewModel.passwordsAreNotEqual)
    }
}


//MARK: - Content view Extension

private struct ContentView: ViewModifier {
    @State var showMenu = false
    @ObservedObject var recipes: RecipeViewModel
    @State var on = true
    
    func body(content: Content) -> some View {
        let drag = DragGesture()
            .onEnded{
                if $0.translation.width < -100 {
                    withAnimation() {
                        showMenu = false
                    }
                }
            }
        
        GeometryReader{ geo in
            ZStack(alignment: .leading) {
                VStack {
                    if on {
                        TopBar(showMenu: $showMenu)
                    }
                    Spacer()
                    content
                    Spacer()
                }
                .frame(width: geo.size.width, height: geo.size.height)
                .offset(x: self.showMenu ? geo.size.width/2 : 0)
                    //.disabled(self.showMenu ? true : false)
                    
    
                if self.showMenu {
                    MenuItemsView(showMenu: $showMenu, recipe: recipes)
                        .frame(width: geo.size.width/2)
                        .transition(.move(edge: .leading))
                }
            }
            .gesture(drag)
        }
    }
}

//MARK: - Inner shadow

private struct InnerShadow: ViewModifier {
    var color: Color = .gray
    var radius: CGFloat = 0.1

    private var colors: [Color] {
        [color.opacity(0.75), color.opacity(0.0), .clear]
    }

    func body(content: Content) -> some View {
        GeometryReader { geo in
            content
//                .overlay(LinearGradient(gradient: Gradient(colors: self.colors), startPoint: .top, endPoint: .bottom)
//                    .frame(height: self.radius * self.minSide(geo)),
//                         alignment: .top)
                .overlay(LinearGradient(gradient: Gradient(colors: self.colors), startPoint: .bottom, endPoint: .top)
                    .frame(height: self.radius * self.minSide(geo)),
                         alignment: .bottom)
                .overlay(LinearGradient(gradient: Gradient(colors: self.colors), startPoint: .leading, endPoint: .trailing)
                    .frame(width: self.radius * self.minSide(geo)),
                         alignment: .leading)
                .overlay(LinearGradient(gradient: Gradient(colors: self.colors), startPoint: .trailing, endPoint: .leading)
                    .frame(width: self.radius * self.minSide(geo)),
                         alignment: .trailing)
                .edgesIgnoringSafeArea(.all)
        }
    }

    func minSide(_ geo: GeometryProxy) -> CGFloat {
        CGFloat(3) * min(geo.size.width, geo.size.height) / 2
    }
}



//MARK: - Extensions

extension TextField {
//    func passwordTextField(image: String, firebaseViewModel: FirebaseViewModel) -> some View {
//        self.modifier(PasswordTextFiels(image: image, firebaseViewModel: firebaseViewModel))
//    }
//
//    func loginTextFields(image: String, firebaseViewModel: FirebaseViewModel) -> some View {
//        self.modifier(LoginTextFiels(image: image, firebaseViewModel: firebaseViewModel))
//    }
//
//    func emailTextFields(image: String, firebaseViewModel: FirebaseViewModel) -> some View {
//        self.modifier(EmailTextFiels(image: image, firebaseViewModel: firebaseViewModel))
//    }
}

extension Color {
    static let mustardYellow = Color("MustartYellow")
    
    static let granola = Color("Granola")
    
    static let lightGrey = Color("LightGrey")
    
    static let darkGrey = Color("DarkGrey")
    
    static let darkGranola = Color("DarkGranola")
    
    static let backgroundColor = Color("BackgroundColor")
    
    static let sageGreen = Color("SageGreen")
    
    static let darkSageGreen = Color("DarkSageGreen")
    
    static let lightBlack = Color("LightBlack")
}


extension View {
    func contentView(recipe: RecipeViewModel, on: Bool) -> some View{
        self.modifier(ContentView(recipes: recipe, on: on))
    }
    
    func innerShadow(color: Color, radius: CGFloat = 0.1) -> some View {
            modifier(InnerShadow(color: color, radius: min(max(0, radius), 1)))
        }
}


extension Sequence {
    func asyncMap<T>(_ transform: (Element) async throws -> T) async rethrows -> [T] {
        var values = [T]()
        
        for element in self {
            try await values.append(transform((element)))
        }
        
        return values
    }
}

extension URLCache {
    
    static let imageCache = URLCache(memoryCapacity: 512*1000*1000, diskCapacity: 10*1000*1000*1000)
}
