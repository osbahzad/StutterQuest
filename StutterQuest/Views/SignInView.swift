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
//  @State var username: String?
//  @State private var input: String
  
  var body: some View {
    VStack {
      Text("Log In")
        .font(.largeTitle)
      Text("Good to see you again!")
      
      TextField("username/email", text:$email)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding(.horizontal, 20)
        .autocapitalization(.none)
      SecureField("Password", text:$password)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding(.horizontal, 20)
        .autocapitalization(.none)
    }
  }
  
}
