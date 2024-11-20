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
                            .frame(width: 380, height: 180)
                            .cornerRadius(10)
                    case .failure:
                        Text("Failed to load image")
                            .foregroundColor(.gray)
                            .frame(width: 380, height: 180)
                            .background(Color(UIColor.systemGray5))
                            .cornerRadius(10)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                // Placeholder image if no valid URL is available
                Image(systemName: "photo")
                  .foregroundColor(.gray)
                  .frame(width: 380, height: 180)
                  .background(Color(UIColor.systemGray5))
                  .cornerRadius(10)
            }

            Text(story.storyName)
              .font(.headline)
              .foregroundColor(.primary)
              .lineLimit(1)
              .truncationMode(.tail)

            Text(story.storyDescription)
              .font(.subheadline)
              .foregroundColor(.secondary)
              .lineLimit(2)
              .multilineTextAlignment(.leading)
        }
        .frame(width: 400, height: 250)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(15)
    }
}

struct StoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        StorySelectionView(nickname: "John")
    }
}
