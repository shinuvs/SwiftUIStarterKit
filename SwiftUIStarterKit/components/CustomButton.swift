//
//  CustomButton.swift
//  SwiftUIStarterKit
//
//  Created by Shinu Vs on 2024-11-04.
//

import SwiftUI

struct CustomButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(8)
        }
    }
}

#Preview {
    CustomButton(title: "Login") {
        
    }
}
