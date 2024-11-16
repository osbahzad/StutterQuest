//
//  StorySelectionView.swift
//  StutterQuest
//
//  Created by Omar Bahzad on 10/31/24.

import SwiftUI

struct StorySelectionView: View {
    @ObservedObject var storyRepository = StoryRepository()
    var nickname: String

    var body: some View {
        NavigationView {
            HStack {
                VStack(alignment: .leading) {
                    // hello and stutterquest at the top
                    HStack {
                      Text("Hi \(nickname.capitalized)!")
                            .font(.title)
                            .fontWeight(.bold)

                        Spacer() // Push stutterquest to the right

                        Text("StutterQuest")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .padding(.horizontal)

                    Spacer()

                    // Horizontal scroll for stories
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(storyRepository.stories) { story in
                                NavigationLink(
                                  destination: StoryView(story: story)
//                                    destination: TestView()
                                ) {
                                    StoryCardView(story: story)
                                }
                                .buttonStyle(PlainButtonStyle()) // Removes the default button styling
                            }
                        }
                        .padding()
                    }

                    Spacer()
                }

                // Navigation bar on the right side
                NavigationBarView()
            }
            .padding()
//            .background(Color(UIColor.systemBackground)) // Background color for the view
            .background(
                            Image("background")
                                .resizable()
                                .scaledToFill()
                        )
            .edgesIgnoringSafeArea(.all)
            
        }
        .navigationBarBackButtonHidden(true)
    }
} 
struct StorySelectionView_Previews: PreviewProvider {
    static var previews: some View {
        StorySelectionView(nickname: "John")
    }
}
