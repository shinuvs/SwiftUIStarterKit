//
//  AppTextFieldGroup.swift
//  Baseframework
//
//  Created by Shinu Vs on 2024-04-01.
//

import SwiftUI

struct AppTextFieldGroup: View {
    
    let label: String
    let placeholder: String
    @Binding var value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
            AppTextField(value: $value, placeholder: placeholder)
        }
        
    }
}

#Preview {
    AppTextFieldGroup(
        label: "Username",
        placeholder: "Placeholder", value: .constant(""))
}
