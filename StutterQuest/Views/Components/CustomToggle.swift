//
//  CustomToggle.swift
//  StutterQuest
//
//  Created by Veronica Benedict on 10/30/24.
//

import SwiftUI

struct CustomToggle: View {
  
  @Binding var signingUp: Bool
  var body: some View {
     HStack(){
      Button(action: {
        withAnimation{
          signingUp = false
        }
      }) {
        Text("Sign in")
          .foregroundColor(signingUp ? .gray : .white)
          .frame(maxWidth: .infinity)
          .padding(.vertical, 10)
          .background(signingUp ? Color.clear : .gray)
          .cornerRadius(15)
      }
      
      Button(action: {
        withAnimation{
          signingUp = true
        }
      }) {
        Text("Sign Up")
          .foregroundColor(!signingUp ? .gray : .white)
          .frame(maxWidth: .infinity)
          .padding(.vertical, 10)
          .background(!signingUp ? Color.clear : .gray)
          .cornerRadius(15)
      }
    }
  }
}
