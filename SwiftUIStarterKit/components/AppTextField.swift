//
//  AppTextfield.swift
//  Baseframework
//
//  Created by Shinu Vs on 2024-04-01.
//

import SwiftUI

struct AppTextField: View {
    
    @Binding var value: String
    let placeholder: String
    
    var body: some View {
        TextField(placeholder, text: $value)
            .textFieldStyle(CustomTextFieldStyle())
    }
}

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 12.0)
                    .stroke(Color.gray, lineWidth: 0.5)
            )
    }
}

#Preview {
    AppTextField(value: .constant(""), placeholder: "Placeholder")
}
