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
      Text("Your child's progress will be saved on this account!")
      
//      Form {
      TextField("Enter Email Address", text:$email)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding(.horizontal, 20)
        .autocapitalization(.none)

      SecureField("Enter password", text:$password)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding(.horizontal, 20)
        .autocapitalization(.none)
//      }
    }
  }
}
