//
//  AddingRecipeView.swift
//  Cookbook
//
//  Created by Alex on 2022-08-03.
//

import SwiftUI

struct AddingRecipeView: View {
    
    private struct DrawingConstants {
        static let titleSize: CGFloat = 35
        static let subcategoriesFontSize: CGFloat = 22
        static let imageCornerRadius: CGFloat = 10
        static let imageWidth: CGFloat = 200
        static let imageHeight: CGFloat = 180
    }
    
    @EnvironmentObject var recipes: RecipeViewModel
    @EnvironmentObject var firebase: FirebaseViewModel
    
    var body: some View {
        VStack {
            Text("Create a recipe")
                .font(.custom("Welland",
                              size: DrawingConstants.titleSize))
                .ignoresSafeArea()
                .foregroundColor(.sageGreen)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    
                    TileAndDescription()
                    
                    Divider()
                    
                    ImageView()
                    
                    
                    Divider()
                    
                    IngredientsAndDirections()
                        
                    Divider()
                        
                    PrepTime()
                    
                    }
                
                Button {
                    Task {
                        await recipes.addRecipe()
                    }
                } label: {
                    Text("Submit Recipe")}
                    .buttonStyle(CustomButton(color: .white))
                
            }
        }
        .contentView(recipe: recipes, on: false)
        .padding(.horizontal)
        .navigationBarTitle(Text(""),
                            displayMode: .inline)
        .background(Color.backgroundColor)
        .ignoresSafeArea(.all, edges: .bottom)
        .sheet(isPresented: $recipes.showPicker, onDismiss: nil) {
            ImagePicker(
                image: $recipes.image,
                showPicker: $recipes.showPicker)}
    }

    struct TileAndDescription: View {
        @EnvironmentObject var recipes: RecipeViewModel
        
        var body: some View {
            VStack(spacing: 10) {
                TextField("Title", text: $recipes.title)
                    .textFieldStyle(TextFieldDesign(image: "square.and.pencil",
                                                    error: false,
                                                    shadow: false))
                
                
                TextField("Description", text: $recipes.description, axis: .vertical)
                    .lineLimit(3, reservesSpace: true)
                    .textFieldStyle(TextFieldDesign(image: "text.alignleft",
                                                    error: false,
                                                    shadow: false,
                                                    height: 80))
            }
        }
    }

    struct ImageView: View {
        @EnvironmentObject var recipes: RecipeViewModel
        
        var body: some View {
            VStack {
                Text("Image")
                    .font(.custom("Welland",
                                  size: DrawingConstants.subcategoriesFontSize))
                    .foregroundColor(.sageGreen)
                if recipes.image == nil {
                Image("köttbullar") // Image(uiImage: ) for stored images
                    .resizable()
                    .cornerRadius(DrawingConstants.imageCornerRadius)
                    .frame(width: DrawingConstants.imageWidth,
                           height: DrawingConstants.imageHeight)
                    .onTapGesture {
                        withAnimation {
                            recipes.showPicker = true
                        }
                    }
                } else {
                    Image(uiImage: recipes.image!)
                        .resizable()
                        .cornerRadius(DrawingConstants.imageCornerRadius)
                        .frame(width: DrawingConstants.imageWidth,
                               height: DrawingConstants.imageHeight)
                        .onTapGesture {
                            withAnimation {
                                recipes.showPicker = true
                            }
                        }
                    }
                }
            }
        }

    struct IngredientsAndDirections: View {
        @EnvironmentObject var recipes: RecipeViewModel
        
        var body: some View {
            VStack {
                Text("Ingredients")
                    .font(.custom("Welland",
                                  size: DrawingConstants.subcategoriesFontSize))
                    .foregroundColor(.sageGreen)
                
                VStack{
                    ForEach(recipes.ingredients) { ingredient in
                        IngredientTextField(i: ingredient,
                                            ingredients: $recipes.ingredients)
                    }
                }
                Divider()
                
                
                
                Text("Directions")
                    .font(.custom("Welland",
                                  size: DrawingConstants.subcategoriesFontSize))
                    .foregroundColor(.sageGreen)
                
                VStack {
                    ForEach(recipes.directions) { direction in
                        DirectionsTextField(dir: direction,
                                            directions: $recipes.directions)
                    }
                }
            }
        }
    }
    
    struct PrepTime: View {
        @EnvironmentObject var recipes: RecipeViewModel
        var body: some View {
            VStack {
                HStack {
                    Text("Prep Time")
                        .font(.custom("Welland",
                                      size: DrawingConstants.subcategoriesFontSize))
                        .foregroundColor(.sageGreen)
                    TextField("Minutes", text: $recipes.dateNow)
                        .textFieldStyle(TextFieldDesign(image: "timer",
                                                        error: false,
                                                        shadow: false))
                }
                
                
                Text("Total time: \(recipes.dateNow)")
                    .font(.custom("Welland",
                                  size: DrawingConstants.subcategoriesFontSize))
                    .foregroundColor(.sageGreen)
            }
        }
    }


}

struct AddingRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        let b = RecipeViewModel()
        let a = FirebaseViewModel(recipeViewModel: b)
        AddingRecipeView()
            .environmentObject(a)
            .environmentObject(b)

    }
}
