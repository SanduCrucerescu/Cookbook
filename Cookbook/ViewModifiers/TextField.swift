//
//  TextField.swift
//  Cookbook
//
//  Created by Alex on 2022-07-26.
//

import SwiftUI

struct TextFieldDesign: TextFieldStyle {
    let image: String
    var error: Bool
    let shadow: Bool
    var height: CGFloat?
    
    private struct DrawingConstants {
        static let frameHeight: CGFloat = 50
        static let shadow: CGFloat = 2
        static let fontSize: CGFloat = 20
        static let imagePading: CGFloat = 8
        static let cornerRadius: CGFloat = 10
        static let textPadding: CGFloat = 5
    }
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack{
            RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                .fill(.white)
                .frame(height: height ?? DrawingConstants.frameHeight)
                .shadow(
                    color: error ? .red : .gray,
                    radius: shadow ? DrawingConstants.shadow : 0)
            HStack{
                Image(systemName: image)
                    .padding(.leading, DrawingConstants.imagePading)
                configuration
                    .font(.system(size: DrawingConstants.fontSize, weight: .light, design: .default))
                    .padding(.trailing, DrawingConstants.textPadding)
            }
        }
    }
}


