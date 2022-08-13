//
//  AddingRecipeView.swift
//  Cookbook
//
//  Created by Alex on 2022-08-03.
//

import SwiftUI

struct CreateRecipeView: View {
    
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
                        Text("Submit Recipe")
                    }
                    .disabled(recipes.emptyTitle || recipes.emptyDescription || recipes.emptyPrepTime)
                    .buttonStyle(CustomButton(color: .white))

                } // Uptdate this in IOS 16
                .onAppear{
                    UIScrollView.appearance().keyboardDismissMode = .onDrag
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
                emptyImage: $recipes.emptyImage,
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
                    .onChange(of: recipes.title) { newValue in
                        recipes.emptyTitle = recipes.title.isEmpty ? true : false
                    }

//                TextField("Description", text: $recipes.description, axis: .vertical)
//                    .lineLimit(3, reservesSpace: true)
//                    .textFieldStyle(TextFieldDesign(image: "text.alignleft",
//                                                    error: recipes.emptyDescription,
//                                                    shadow: recipes.emptyDescription,
//                                                    height: 80))
                TextField("Description", text: $recipes.description)
                    .textFieldStyle(TextFieldDesign(image: "square.and.pencil",
                                                    error: recipes.emptyDescription,
                                                    shadow: recipes.emptyDescription,
                                                    height: 80))
                    .onChange(of: recipes.description) { newValue in
                        recipes.emptyDescription = recipes.description.isEmpty ? true : false
                    }
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
                ZStack {
                    RoundedRectangle(cornerRadius: DrawingConstants.imageCornerRadius)
                        .stroke(recipes.emptyImage ? .red : .black,
                                lineWidth: recipes.emptyImage ? 5 : 0)
                    Image("köttbullar") // Image(uiImage: ) for stored images
                        .resizable()
                        .cornerRadius(DrawingConstants.imageCornerRadius)
                        .onTapGesture {
                            withAnimation {
                                recipes.showPicker = true
                            }
                        }
                    Text("Tap to \nadd a image")
                        .font(.custom("Welland",
                                      size: DrawingConstants.subcategoriesFontSize))
                        .foregroundColor(.white)
                    }
                    .frame(width: DrawingConstants.imageWidth,
                       height: DrawingConstants.imageHeight)
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
                
                
                ForEach(Array(recipes.directions.enumerated()) , id: \.1) { index, direction in
                    DirectionsTextField(index: index,
                                        direction: direction,
                                        directions: $recipes.directions)
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
                        .onChange(of: recipes.prepTime) { newValue in
                            recipes.emptyPrepTime = recipes.prepTime.isEmpty ? true : false
                        }
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
        CreateRecipeView()
            .environmentObject(a)
            .environmentObject(b)

    }
}
