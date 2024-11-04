//
//  Login.swift
//  SwiftUIStarterKit
//
//  Created by Shinu Vs on 2024-11-04.
//

import SwiftUI

struct LoginView: View {
    
    // State properties to hold the input values
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String? = nil // To show error messages

    var body: some View {
        VStack(spacing: 20) {
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.bold)

            // Email Field
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocapitalization(.none)

            // Password Field
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            // Show error message if any
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.footnote)
            }

            // Login Button
            Button(action: handleLogin) {
                Text("Login")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        }
        .padding()
    }

    // Action for the login button
    func handleLogin() {
        // Basic validation
        if email.isEmpty || password.isEmpty {
            errorMessage = "Please fill in both fields."
            return
        }
        
        errorMessage = nil
        
        // Simulate an API call with delay
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            DispatchQueue.main.async {
                if email == "user@example.com" && password == "password" {
                    print("Login successful")
                    errorMessage = nil // Clear any error
                    // Navigate to another view or show success message
                } else {
                    errorMessage = "Invalid email or password."
                }
            }
        }
    }

}

#Preview {
    LoginView()
}
