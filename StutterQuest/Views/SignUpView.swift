//
//  SignUpView.swift
//  StutterQuest
//
//  Created by Veronica Benedict on 10/30/24.
//

import SwiftUI

struct SignUpView: View {
    @Binding var email: String
    @Binding var password: String
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Create your account")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color(red: 0.42, green: 0.55, blue: 0.49))
            
            Text("Your child's progress will be saved on this account!")
                .font(.system(size: 14))
                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                .multilineTextAlignment(.center)
                .padding(.bottom, 10)
            
            VStack(spacing: 15) {
              CustomTextFieldSignUp(placeholder: "Enter Email Address", text: $email, imageName: "envelope")
              CustomSecureFieldSignUp(placeholder: "Enter password", text: $password, imageName: "lock")
            }
            .frame(width: 350)
        }
        .padding()
    }
}

struct CustomTextFieldSignUp: View {
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

struct CustomSecureFieldSignUp: View {
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
    SignUpView(email: .constant(""), password: .constant(""))
}
