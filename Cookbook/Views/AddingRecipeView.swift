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
    @State var retrivedImage: UIImage?
    @State var title: String = ""
    @State var description: String = ""
    
    @EnvironmentObject var recipes: RecipeViewModel
    @EnvironmentObject var firebase: FirebaseViewModel
    
    @State var ingredients: Array<Ingredient> = [Ingredient(description: "")]
    
    
    var body: some View {
        Text("Create a recipe")
            .font(.custom("Welland",
                          size: 35))
            .foregroundColor(.sageGreen)
        VStack(alignment: .leading) {
            ScrollView(showsIndicators: false){
                    TextField("Title", text: $title)
                        .textFieldStyle(TextFieldDesign(image: "square.and.pencil", error: false, shadow: false))
                    
                    TextField("Description", text: $description)
                        .textFieldStyle(TextFieldDesign(image: "text.alignleft", error: false, shadow: false))
                    Text("Image")
                        .font(.custom("Welland",
                                      size: 22))
                        .foregroundColor(.sageGreen)
                    
                    Image("köttbullar") // Image(uiImage: ) for stored images
                        .resizable()
                        .cornerRadius(10)
                        .frame(width: 200, height: 180)
                    
                    Text("Ingredients")
                        .font(.custom("Welland",
                                      size: 22))
                        .foregroundColor(.sageGreen)
                
                    VStack{
                        ForEach(ingredients) { ingredient in
                            IngredientTextField(i: ingredient, ingredients: $ingredients)
                        }
                   }
                    
    //                Button (
    //                    action: {firebase.uploadImage(image!)}
    //                ) {
    //                    Text("Upload Image")
    //                }
                    
    //                Button (
    //                    action: {firebase.getPhoto()}
    //                ) {
    //                    Text("Get image")
       //             }
                        
                    }
                .padding(.horizontal)
                .contentView(recipe: recipes, on: false)
                .background(Color.backgroundColor)
                //.ignoresSafeArea()
                .sheet(isPresented: $showPicker, onDismiss: nil) {
                        ImagePicker(
                            image: $image,
                        showPicker: $showPicker)}
        }
        .navigationBarTitle(Text(""), displayMode: .inline)

        .ignoresSafeArea(.all, edges: .bottom)
    
}

}
struct AddingRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        let recipe = RecipeViewModel()
        let firebaseViewModel = FirebaseViewModel(recipeViewModel: recipe)
        AddingRecipeView()
            .environmentObject(recipe)
            .environmentObject(firebaseViewModel)

    }
}


