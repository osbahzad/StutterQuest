//
//  ContentView.swift
//  StutterQuest
//
//  Created by Omar Bahzad on 10/28/24.
//

import SwiftUI

struct ContentView: View {
  @StateObject private var authViewModel = AuthViewModel()
  @State private var signingUp = true
  @State private var email = ""
  @State private var password = ""
  @State private var nickname = ""
  @State private var signed_in = false
  @State private var showAlert = false
  @State private var alertMessage = ""
  @State private var username_saved = false
  
  // compute combined boolean for new user
  private var needNickname: Bool {
    return signingUp && signed_in
  }
  var body: some View {
    NavigationView {
      ZStack{
        Image("login_backgound")
          .resizable()
          .scaledToFill()
          .edgesIgnoringSafeArea(.all)
        VStack {
          Text("StutterQuest")
            .bold()
            .font(.title)
          CustomToggle(signingUp: $signingUp)
          if(signingUp) {
            SignUpView(email: $email, password: $password)
          } else {
            SignInView(email: $email, password: $password)
          }
          Button(action: {
            Task {
              if signingUp {
                await authViewModel.signUp(email: email, password: password)
              } else {
                await authViewModel.signIn(email:email, password: password)
              }
              try? await Task.sleep(nanoseconds: 1_000_000_000)
              if authViewModel.user != nil { 
                  signed_in = true
              }
              if let errorMessage = authViewModel.errorMessage {
                alertMessage = errorMessage
                showAlert = true
              }
            }
          }) {
            Text("Continue")
              .font(.title) // Make the text larger
              .padding()    // Add padding inside the button
              .frame(width: 200, height: 50) // Set the button size
              .background(Color.orange)
              .foregroundColor(.white)
              .cornerRadius(20)
          }
          .frame(width: 400, height: 50)
        }
        
        .background(
            Group {
                if signingUp {
                  NavigationLink(destination: SelectNicknameView(nickname: $nickname, username_saved: username_saved, authViewModel: authViewModel), isActive: .constant(needNickname)) {
                        EmptyView()
                    }
                } else {
                    NavigationLink(destination: SelectStoryView(), isActive: $signed_in) {
                        EmptyView()
                    }
                }
            }
        )
        
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
      }
      
    }
}


#Preview {
    ContentView()
}
