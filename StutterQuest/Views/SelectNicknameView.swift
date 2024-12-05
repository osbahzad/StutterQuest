
//
//  SelectNicknameView.swift
//  StutterQuest
//
//  Created by Veronica Benedict on 11/6/24.
//

import SwiftUI

struct SelectNicknameView: View {
  @Binding var nickname: String
  var email: String
  @State var username_saved: Bool
  var authViewModel: AuthViewModel
    var body: some View {
      ZStack {
        Image("nickname_background")
          .resizable()
          .scaledToFill()
          .edgesIgnoringSafeArea(.all)
        
        VStack {
          Text("Select a Nickname")
            .font(.largeTitle)
            .padding()
          TextField("Enter Nickname", text: $nickname)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal, 20)
            .autocapitalization(.none)
          
          Button(action: {
            print("username", nickname)
            if !nickname.isEmpty {
              if let user = authViewModel.user {
                Task {
                  await authViewModel.save_nickname(userID: user.user_id, nickname: nickname)
                  username_saved = true
                }
              }
            }
          }) {
            Text("Continue")
              .font(.title)
              .padding()
              .frame(width: 200, height: 50)
              .background(Color.orange)
              .foregroundColor(.white)
              .cornerRadius(20)
          }
        }
        .navigationBarBackButtonHidden(true)
        .padding()
        .background(
          NavigationLink(destination: StorySelectionView(nickname:nickname, email: email), isActive: $username_saved) {
            EmptyView()
          })
      }
    }
}
