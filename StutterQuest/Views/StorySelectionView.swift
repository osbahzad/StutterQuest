//
//  StorySelectionView.swift
//  StutterQuest
//
//  Created by Omar Bahzad on 10/31/24.


import SwiftUI

struct StorySelectionView: View {
  
  @ObservedObject var storyRepository = StoryRepository()
  @ObservedObject var authViewModel = AuthViewModel()
  var nickname: String
  var email: String
 
  var body: some View {
    NavigationView {
      VStack{
        if authViewModel.signedIn{
          
          HStack() {
            VStack(alignment: .leading) {
              
              Text("Hi \(nickname.capitalized)!")
                .font(.system(size: 40, weight: .bold))
                .padding(.leading)
              
              // Horizontal scroll for stories
              ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 25) {
                  
                  ForEach(storyRepository.stories) { story in
                    NavigationLink(
                      destination: StoryView(story: story)
                    ) {
                      StoryCardView(story: story)
                    }
                    .buttonStyle(PlainButtonStyle())
                  }
              ForEach(storyRepository.stories) { story in
                NavigationLink(
                  destination: StoryView(authViewModel: AuthViewModel(), story: story, nickname: nickname, email: email)
                ) {
                  StoryCardView(story: story, email: email, authViewModel: AuthViewModel())
                }
              }
              Button(action: {
                Task {
                  
                  await authViewModel.logout(email: email)
                }
              }) {
                Text("Logout")
                  .foregroundColor(.white)
                  .padding()
                  .background(Color.red)
                  .cornerRadius(8)
              }
              .padding(.top, 20)
            }
            .padding()
            
            NavigationBarView(email: email, nickname: nickname)
              .frame(width: 70)
          }
          
          .padding(.top, 20)
          
          .background(
            Image("login_background")
              .edgesIgnoringSafeArea(.all)
          )
        } else {
            NavigationLink(destination: ContentView(), isActive: .constant(true)) {
                EmptyView()
            }
          }
        }
      }
    .navigationBarBackButtonHidden(true)
  }
}
