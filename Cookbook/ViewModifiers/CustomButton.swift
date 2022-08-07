//
//  CustomButton.swift
//  Cookbook
//
//  Created by Alex on 2022-07-26.
//

import SwiftUI

struct CustomButton: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabeled
    var color: Color
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 15
        static let frameHeight: CGFloat = 60
        static let buttonWidth: CGFloat = 200
        static let textSize: CGFloat = 20
    }
    
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack{
            RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                .fill(Color.sageGreen)
                .frame(height: DrawingConstants.frameHeight)
                .frame(width: DrawingConstants.buttonWidth)
            configuration
                .label
                .foregroundColor(color)
                .font(.custom("Welland",
                              size: DrawingConstants.textSize))
        }
    }
}

