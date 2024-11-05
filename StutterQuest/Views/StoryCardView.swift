//
//  StoryCardView.swift
//  StutterQuest
//
//  Created by Omar Bahzad on 11/1/24.
// Help with AI


import SwiftUI

struct StoryCardView: View {
    let story: Story

    init(story: Story) {
        self.story = story
        // Print for debugging purposes
        if let firstImage = story.images.first {
            print("First image URL for \(story.storyName): \(firstImage)")
        } else {
            print("No images available for \(story.storyName)")
        }
    }

    var body: some View {
        VStack {
            // Use the first image URL from the images array for the preview
            if let firstImageURL = story.images.first, let url = URL(string: firstImageURL) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView() // Show a loading indicator while the image is loading
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 180, height: 100)
                            .clipped()
                            .cornerRadius(10)
                            .padding(.top)
                    case .failure:
                        Text("Failed to load image")
                            .foregroundColor(.gray)
                            .frame(width: 180, height: 100)
                            .background(Color(UIColor.systemGray5))
                            .cornerRadius(10)
                            .padding(.top)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                // Placeholder image if no valid URL is available
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 100)
                    .foregroundColor(.gray)
                    .padding(.top)
            }

            Text(story.storyName)
                .font(.headline)
                .padding(.top, 5)

            Text(story.storyDescription)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing, .bottom])
        }
        .frame(width: 200, height: 250)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}
