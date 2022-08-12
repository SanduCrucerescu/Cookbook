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
                    if recipes.emptyTitle || recipes.emptyDescription || recipes.emptyPrepTime {
                        Text("Please fill all of the fields")
                            .font(.custom("Welland",
                                          size: 20))
                            .ignoresSafeArea()
                            .foregroundColor(.red)
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
        .navigationBarTitle(Text(""),
                            displayMode: .inline)
        .toolbar{
            EditButton()
        }
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
                                                    error: recipes.emptyTitle,
                                                    shadow: recipes.emptyTitle))
                    
                
                
//                TextField("Description", text: $recipes.description, axis: .vertical)
//                    .lineLimit(3, reservesSpace: true)
//                    .textFieldStyle(TextFieldDesign(image: "text.alignleft",
//                                                    error: recipes.emptyDescription,
//                                                    shadow: recipes.emptyDescription,
//                                                    height: 80))
                TextField("Description", text: $recipes.description)
                    .textFieldStyle(TextFieldDesign(image: "text.alignleft",
                                                    error: recipes.emptyDescription,
                                                    shadow: recipes.emptyDescription,
                                                    height: 80))
            }
            .padding()
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
                .padding()
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
                
//                IngredientTextField(index: 0,
//                                    ingredients: $recipes.ingredients)
//                ForEach(Array(recipes.ingredients.enumerated()), id: \.1) { index, ingredient in
//                    IngredientTextField(index: index + 1,
//                                            ingredient: ingredient,
//                                            ingredients: $recipes.ingredients)
//                    }
//
                
                    ForEach(Array(recipes.ingredients.enumerated()), id: \.1) { index, ingredient in
                            IngredientTextField(index: index,
                                                ingredient: ingredient,
                                                ingredients: $recipes.ingredients)
                        }
                
                
                
                
                Divider()
                
                
                Text("Directions")
                    .font(.custom("Welland",
                                  size: DrawingConstants.subcategoriesFontSize))
                    .foregroundColor(.sageGreen)
                
                VStack {
                    ForEach(0..<recipes.directions.count , id: \.self) { index in
                        DirectionsTextField(index: index, directions: $recipes.directions)
                    }
                }
            }
            .padding()
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
                    TextField("Minutes", text: $recipes.prepTime)
                        .textFieldStyle(TextFieldDesign(image: "timer",
                                                        error: recipes.emptyPrepTime,
                                                        shadow: recipes.emptyPrepTime))
                }
                
                
                Text("Total time: \(recipes.prepTime)")
                    .font(.custom("Welland",
                                  size: DrawingConstants.subcategoriesFontSize))
                    .foregroundColor(.sageGreen)
            }
            .padding()
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
