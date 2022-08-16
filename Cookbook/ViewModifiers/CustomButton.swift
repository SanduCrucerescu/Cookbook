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
    var height: CGFloat?
    var width: CGFloat?
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 15
        static let frameHeight: CGFloat = 60
        static let buttonWidth: CGFloat = 200
        static let textSize: CGFloat = 20
    }
    
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack{
            RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                .fill(configuration.isPressed ? Color.sageGreen.opacity(0.5) : Color.sageGreen)
                .frame(width: width ?? DrawingConstants.buttonWidth,
                       height: height ?? DrawingConstants.frameHeight)
                .scaleEffect(configuration.isPressed ? 1.2 : 1)
                .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
                //.background(isEnabeled ? Color.sageGreen : Color.lightGrey)
                
            configuration
                .label
                .foregroundColor(color)
                .font(.custom("Welland",
                              size: DrawingConstants.textSize))
        }
    }
}

