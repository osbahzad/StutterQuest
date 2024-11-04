//
//  StoryView.swift
//  StutterQuest
//
//  Created by Wenchao Hu on 11/3/24.
//

import SwiftUI

struct StoryView: View {
  
    let story: Story
    @State private var currentPage = 0

    var body: some View {
        VStack {
            if currentPage < story.images.count && currentPage < story.sentences.count {
              
                // Display the current image
                if let url = URL(string: story.images[currentPage]) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                          ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxHeight: 250)
                                .cornerRadius(10)
                                .padding()
                        case .failure:
                            Text("Failed to load image")
                                .foregroundColor(.gray)
                        @unknown default:
                            EmptyView()
                        }
                    }
                }

                // Display the current sentence
                Text(story.sentences[currentPage])
                    .font(.title)
                    .padding()
                    .multilineTextAlignment(.center)

                Spacer()

                // Next button to navigate to the next page
                Button(action: {
                    currentPage += 1
                }) {
                    Text("Next")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            } else {
                // Story completed view
                VStack {
                    Text("Story Completed!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()

                    Text("Thank you for reading.")
                        .font(.title2)
                        .foregroundColor(.secondary)
                        .padding()

                    // Restart button to go back to the beginning of the story
                    Button(action: {
                        currentPage = 0
                    }) {
                        Text("Read Again")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                }
            }
        } 
        .navigationTitle(story.storyName)
        .navigationBarTitleDisplayMode(.inline)
      
    }
}

