//
//  FirstResponderTextField.swift
//  Cookbook
//
//  Created by Alex on 2022-08-16.
//

import Foundation
import SwiftUI


struct FirstResponderTextField: UIViewRepresentable {
    
    @Binding var text: String
    let placeHolder: String
        
    func makeCoordinator() -> CoordonatorText {
        return CoordonatorText(text: $text)
    }
    
    func makeUIView(context: Context) -> some UIView {
        let textField = UITextField()
        textField.layer.borderWidth = 2
        textField.delegate = context.coordinator
        textField.placeholder = placeHolder
        return textField
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if !context.coordinator.becomeFirstResponder {
            uiView.becomeFirstResponder()
            context.coordinator.becomeFirstResponder = true
        }
    }
}

class CoordonatorText: NSObject, UITextFieldDelegate {
    @Binding var text: String
    var becomeFirstResponder = false
    
    init(text: Binding<String>) {
        self._text = text
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        text = textField.text ?? ""
    }
}
