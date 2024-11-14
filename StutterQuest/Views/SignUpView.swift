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
    VStack {
      Text("Create your account")
        .font(.largeTitle)
        .fontWeight(.bold)
        .foregroundColor(Color(red: 0.42, green: 0.55, blue: 0.49)) // #6c8c7d
      
      Text("Your child's progress will be saved on this account!")
        .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2)) // Dark Charcoal
      
//      Form {
      TextField("Enter Email Address", text:$email)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding(.horizontal, 20)
        .autocapitalization(.none)
      
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)

      SecureField("Enter password", text:$password)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding(.horizontal, 20)
        .autocapitalization(.none)
      
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
//      }
    }
  }
}
