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
    HStack(spacing: 20) {
      Button(action: {
        withAnimation{
          signingUp = false
        }
        
      }) {
        Text("Log In")
          .font(.system(size: 18, weight: .bold))
          .foregroundColor(signingUp ? .gray : .white)
          .frame(width: 200)
        
          .padding(.vertical, 10)
          .background(signingUp ? Color.clear : Color(red: 0.42, green: 0.55, blue: 0.49))
          .cornerRadius(15)
          .overlay(
            RoundedRectangle(cornerRadius: 15)
              .stroke(signingUp ? Color(red: 0.42, green: 0.55, blue: 0.49) : Color.clear, lineWidth: 2)
          )
      }
      
      Button(action: {
        withAnimation{
          signingUp = true
        }
      }) {
        Text("Sign Up")
          .font(.system(size: 16, weight: .bold))
          .foregroundColor(!signingUp ? .gray : .white)
          .frame(width: 200)
        
          .padding(.vertical, 10)
          .background(!signingUp ? Color.clear : Color(red: 0.42, green: 0.55, blue: 0.49))
          .cornerRadius(15)
          .overlay(
            RoundedRectangle(cornerRadius: 15)
              .stroke(!signingUp ? Color.gray : Color.clear, lineWidth: 2)
          )
      }
    } 
  }
}

#Preview {
    CustomToggle(signingUp: .constant(false))
}
