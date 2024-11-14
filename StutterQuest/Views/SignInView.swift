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
    VStack {
      
      Text("Log In")
        .font(.largeTitle)
        .fontWeight(.bold)
        .foregroundColor(Color(red: 0.42, green: 0.55, blue: 0.49)) // #6c8c7d

      
      Text("Good to see you again!")
        .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2)) // Dark Charcoal
                  
      // Email and Password Fields
      VStack() {
          TextField("Enter your email", text: $email)
//              .padding()
//              .background(Color.white)
//              .cornerRadius(10)
//              .shadow(radius: 2)
        
              .textFieldStyle(RoundedBorderTextFieldStyle())
              .padding(.horizontal, 20)
              .autocapitalization(.none)
        
              .background(Color.white)
              .cornerRadius(10)
              .shadow(radius: 2)

          SecureField("Enter your password", text: $password)
//              .padding()
//              .background(Color.white)
//              .cornerRadius(10)
//              .shadow(radius: 2)
        
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal, 20)
            .autocapitalization(.none)
        
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 2)
      }
    }
  }
  
}


#Preview {
    SignInView(email: .constant(""), password: .constant(""))
}

