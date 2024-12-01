//
//  StorySelectionView.swift
//  StutterQuest
//
//  Created by Omar Bahzad on 10/31/24.


import SwiftUI

struct StorySelectionView: View {
    @ObservedObject var storyRepository = StoryRepository()
    var nickname: String

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
                                
                                // Add the locked story card at the end
                                LockedStoryCardView()
                            }
                        }
                    }
                    .padding()

                    NavigationBarView()
                        .frame(width: 70)
                }
                .padding(.top, 20)

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
                        .padding(.trailing, 40) // Adjusted padding to move it left
                    }
                    Spacer()
                }

                // NavigationLink to TutorialView
                NavigationLink(
                    destination: TutorialView(onComplete: {
                        showTutorial = false
                    }),
                    isActive: $showTutorial
                ) {
                    EmptyView()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}



 
struct StorySelectionView_Previews: PreviewProvider {
  static var previews: some View {
    StorySelectionView(nickname: "John")
  }
}
