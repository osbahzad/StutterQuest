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
    @State private var showTutorial = false // State to control tutorial navigation

    var body: some View {
        NavigationView {
            ZStack {
                // Background
                Image("login_background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                // Main content
                HStack {
                    VStack(alignment: .leading) {
                        // Greeting
//                      Spacer()
                        Text("Hi \(nickname.capitalized)!")
                            .font(.system(size: 40, weight: .bold))
                            .padding(.leading)
                            .padding(.top, 10)

                        // Horizontal scroll for stories
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 25) {
                                ForEach(storyRepository.stories) { story in
                                  NavigationLink(
                                    destination: StoryView(authViewModel: authViewModel, story: story, nickname: nickname, email: email)
                                  ) {
                                    StoryCardView(story: story, email: email, authViewModel: authViewModel)
                                  }
                                    .buttonStyle(PlainButtonStyle())
                                }
                                
                                // Add the locked story card at the end
                                LockedStoryCardView()
                            }
                        }
//                        .padding(.leading)
                      Button(action: {
                        Task {
                          await authViewModel.logout(email: email)
                        }
                      }) {
                        Text("Logout")
                          .foregroundColor(.white)
                          .padding()
                          .background(Color(red: 0.42, green: 0.55, blue: 0.49))
                          .cornerRadius(8)
                      }
                      .padding(.bottom, 20)
                      .padding(.leading)
                    }
                    .padding(.top, 20)
                  NavigationBarView(email: email, nickname: nickname)
                        .frame(width: 100)
//                        .padding(.leading, 20)
                        .padding(.top, 30)
                        .padding(.bottom, 30)
                        .padding(.trailing, 80)
                        
//                  Spacer()
                }
//                Spacer()

                // Tutorial Button
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            showTutorial = true
                        }) {
                            Image(systemName: "questionmark.circle")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding()
                        }
                        .background(Color.white.opacity(0.8))
                        .clipShape(Circle())
                        .shadow(radius: 5)
                        .padding(.trailing, 200) // Adjusted padding to move it left
                    }
                    Spacer()
                }
                .padding(.top, 30)

                // NavigationLink to TutorialView
                NavigationLink(
                    destination: TutorialView(onComplete: {
                        showTutorial = false
                    }),
                    isActive: $showTutorial
                ) {
                    EmptyView()
                }
              if !authViewModel.signedIn {
                  NavigationLink(destination: ContentView(), isActive: .constant(true)) {
                      EmptyView()
                  }
              }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

