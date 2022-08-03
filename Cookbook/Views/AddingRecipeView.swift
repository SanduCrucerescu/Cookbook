//
//  AddingRecipeView.swift
//  Cookbook
//
//  Created by Alex on 2022-08-03.
//

import SwiftUI

struct AddingRecipeView: View {
    
    private struct DrawingConstants {
        static let backButtonIconFrameWidth: CGFloat = 20
        static let backButtonIconFrameHeight: CGFloat = 30
        static let backButtonHeightIphone8: CGFloat = 520
        static let backButtonHeightIphone13: CGFloat = 600
        static let backButtonPaddingButtom: CGFloat = 700
        static let backButtonPaddingTrailing: CGFloat = 330
    }
    
    let height = UIScreen.main.bounds.height
    var width = UIScreen.main.bounds.width
    
    @State var showPicker: Bool = false
    @State var image: UIImage?
    
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var recipes: RecipeViewModel
    @EnvironmentObject var firbase: FirebaseViewModel
    
    
    var body: some View {
        ZStack {
            Button(
                action: {viewRouter.page = .MainPage}) {
                    Image(systemName: "chevron.left")
                        .resizable(resizingMode: .stretch)
                        .foregroundColor(.gray)
                        .frame(
                            width: DrawingConstants.backButtonIconFrameWidth,
                            height: DrawingConstants.backButtonIconFrameHeight)
                }
                .padding(.bottom, height < 700
                         ? DrawingConstants.backButtonHeightIphone8
                         : DrawingConstants.backButtonHeightIphone13)
                .padding(.trailing, DrawingConstants.backButtonPaddingTrailing)
            VStack{
                if image != nil {
                        Image(uiImage: image!)
                            .resizable()
                            .frame(width: 200, height: 200)
                    }

                Button(
                    action: {showPicker = true}
                )
                    {
                        Text("Select image")
                    }
                
                Button (
                    action: {firbase.uploadImage(image!)}
                ) {
                    Text("Upload Image")
                }
                    
                }.sheet(isPresented: $showPicker, onDismiss: nil) {
                    ImagePicker(
                        image: $image,
                        showPicker: $showPicker)
                
        }
            .contentView(viewRouter: viewRouter, recipe: recipes)
    }
}

}
struct AddingRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewRouter = ViewRouter()
        let recipe = RecipeViewModel()
        let firebaseViewModel = FirebaseViewModel(recipeViewModel: recipe)
        AddingRecipeView()
            .environmentObject(viewRouter)
            .environmentObject(recipe)
            .environmentObject(firebaseViewModel)

    }
}