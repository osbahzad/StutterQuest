//
//  SignInView.swift
//  StutterQuest
//
//  Created by Veronica Benedict on 10/30/24.
//

import SwiftUI

struct SignInView: View {
    @Binding var email: String
    @Binding var password: String
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Good to see you again!")
              .font(.system(size: 24, weight: .bold))
              .foregroundColor(Color(red: 0.42, green: 0.55, blue: 0.49))
            
            VStack(spacing: 15) {
              CustomTextField(placeholder: "Enter your email", text: $email, imageName: "envelope")
              CustomSecureField(placeholder: "Enter your password", text: $password, imageName: "lock")
            }
              .frame(width: 350)
        }
        .padding()
    }
}

struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String
    let imageName: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .foregroundColor(.gray)
                .frame(width: 20)
                .padding(.leading, 8)
            
            TextField(placeholder, text: $text)
                .padding(.vertical, 10)
        }
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .autocapitalization(.none)
    }
}

struct CustomSecureField: View {
    let placeholder: String
    @Binding var text: String
    let imageName: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .foregroundColor(.gray)
                .frame(width: 20)
                .padding(.leading, 8)
            
            SecureField(placeholder, text: $text)
                .padding(.vertical, 10)
        }
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .autocapitalization(.none)
    }
}

#Preview {
    SignInView(email: .constant(""), password: .constant(""))
}
