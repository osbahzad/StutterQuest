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
    @State private var showTutorial = false

    var body: some View {
        NavigationView {
            // Main Content
            ZStack {
                Image("login_background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                HStack {
                    VStack(alignment: .leading) {
                        Text("Hi \(nickname.capitalized)!")
                            .font(.system(size: 40, weight: .bold))
                            .padding(.leading)
                            .padding(.top, 10)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(storyRepository.stories) { story in
                                    NavigationLink(
                                        destination: StoryView(authViewModel: authViewModel, story: story, nickname: nickname, email: email)
                                    ) {
                                        StoryCardView(story: story, email: email, authViewModel: authViewModel)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                                
                                LockedStoryCardView()
                            }
                        }
                      
                        // Log out Button
                        Button(action: {
                            Task {
                                await authViewModel.logout(email: email)
                            }
                        }) {
                            Text("Logout")
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color(red: 0.42, green: 0.55, blue: 0.49))
                                .cornerRadius(8)
                                
                        }
                    }
                  
                    NavigationBarView(email: email, nickname: nickname)
                        .frame(width: 80)
                        .padding(.top, 30)
                        .padding(.trailing, 40)
                }.padding(.top, 20)
                
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
                        }
                        .background(Color.white.opacity(0.8))
                        .clipShape(Circle())
                        .shadow(radius: 5)
                        .padding(.trailing, 140)
                    }
                    Spacer()
                }
                .padding(.top, 50)

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

#Preview {
    StorySelectionView(nickname: "Demo", email: "demo@gmail.com")
}
