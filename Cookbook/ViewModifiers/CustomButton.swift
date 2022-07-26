//
//  CustomButton.swift
//  Cookbook
//
//  Created by Alex on 2022-07-26.
//

import SwiftUI

struct CustomButton: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabeled
    
    private struct DrawingConstants{
        static let cornerRadius: CGFloat = 10
        static let frameHeight: CGFloat = 60
        static let padding: CGFloat = 60
    }
    
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack{
            RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                .fill(Color.mustardYellow)
                .frame(height: DrawingConstants.frameHeight)
                .padding(.horizontal, DrawingConstants.padding)
            configuration
                .label
                .foregroundColor(.black)
                .font(.system(size: 20, weight: .regular, design: .default))
        }
    }
}

