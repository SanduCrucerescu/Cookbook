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
    @State var directions: Array<Direction> = [Direction(direction: "sas")]
    @State var dateNow = ""
    @State var showPiker = false
    
    
    var body: some View {
        VStack {
            Text("Create a recipe")
                .font(.custom("Welland",
                              size: DrawingConstants.titleSize))
                .ignoresSafeArea()
                .foregroundColor(.sageGreen)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    Group {
                        TextField("Title", text: $title)
                            .textFieldStyle(TextFieldDesign(image: "square.and.pencil",
                                                            error: false,
                                                            shadow: false))

                        TextField("Description", text: $description)
                            .textFieldStyle(TextFieldDesign(image: "text.alignleft",
                                                            error: false,
                                                            shadow: false))
                        Divider()
                    
                        Text("Image")
                            .font(.custom("Welland",
                                          size: DrawingConstants.subcategoriesFontSize))
                            .foregroundColor(.sageGreen)
                    
                    }
                    
                    Group {
                        Image("köttbullar") // Image(uiImage: ) for stored images
                        .resizable()
                        .cornerRadius(DrawingConstants.imageCornerRadius)
                        .frame(width: DrawingConstants.imageWidth,
                               height: DrawingConstants.imageHeight)
                        Divider()
                        Text("Ingredients")
                            .font(.custom("Welland",
                                          size: DrawingConstants.subcategoriesFontSize))
                            .foregroundColor(.sageGreen)
                    
                        VStack{
                            ForEach(ingredients) { ingredient in
                                IngredientTextField(i: ingredient,
                                                    ingredients: $ingredients)
                            }
                        }
                        Divider()
                        
                    }
                        
                    Text("Directions")
                        .font(.custom("Welland",
                                      size: DrawingConstants.subcategoriesFontSize))
                        .foregroundColor(.sageGreen)

                    VStack {
                        ForEach(directions) { direction in
                            DirectionsTextField(dir: direction,
                                                directions: $directions)
                        }
                    }
                    Divider()
                    
                    HStack {
                        Text("Prep Time")
                            .font(.custom("Welland",
                                          size: DrawingConstants.subcategoriesFontSize))
                            .foregroundColor(.sageGreen)
                        TextField("Minutes", text: $dateNow)
                            .textFieldStyle(TextFieldDesign(image: "timer",
                                                            error: false,
                                                            shadow: false))
                    }
                    
                    Text("Total time: \(dateNow)")
                        .font(.custom("Welland",
                                      size: DrawingConstants.subcategoriesFontSize))
                        .foregroundColor(.sageGreen)
                    
                }
                Button {
                    recipes.addRecipe(directions)
                } label: {
                    Text("Submit Recipe")
                        
                }
                .buttonStyle(CustomButton(color: .white))
            }
        }
        .contentView(recipe: recipes, on: false)
        .padding(.horizontal)
        .navigationBarTitle(Text(""), displayMode: .inline)
        .background(Color.backgroundColor)
        .ignoresSafeArea(.all, edges: .bottom)
        .sheet(isPresented: $showPicker, onDismiss: nil) {
                ImagePicker(
                    image: $image,
                showPicker: $showPicker)}
        
    }
}

//struct AddingRecipeView_Previews: PreviewProvider {
//    static var previews: some View {
//        let recipe = RecipeViewModel()
//        let firebaseViewModel = FirebaseViewModel(recipeViewModel: recipe)
//        AddingRecipeView()
//            .environmentObject(recipe)
//            .environmentObject(firebaseViewModel)
//
//    }
//}


