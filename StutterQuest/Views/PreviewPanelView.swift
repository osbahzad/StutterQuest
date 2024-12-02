//
//  PreviewPanelView.swift
//  StutterQuest
//
//  Created by Wenchao Hu on 11/20/24.
//


import SwiftUI

struct PreviewPanelView: View {
    let story: Story
    let currentPage: Int
    let onImageTap: (Int) -> Void

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.black)
                .frame(height: 100)
                .edgesIgnoringSafeArea(.bottom)

            HStack(spacing: 10) {
                ForEach(0..<5) { index in
                    let imageIndex = (currentPage / 5) * 5 + index
                    if imageIndex < story.images.count {
                        previewImage(for: imageIndex)
                            .onTapGesture {
                                onImageTap(imageIndex)
                            }
                    } else {
                        placeholderImage
                    }
                }
            }
            .padding(.horizontal)
        }
    }

    private func previewImage(for index: Int) -> some View {
        let imageUrl = URL(string: story.images[index])
        return AsyncImage(url: imageUrl) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 60)
                    .clipped()
                    .cornerRadius(8)
                    .opacity(index == currentPage ? 1.0 : 0.5)
            case .failure:
                placeholderImage
            @unknown default:
                EmptyView()
            }
        }
    }

    private var placeholderImage: some View {
        Color.gray
            .frame(width: 60, height: 60)
            .cornerRadius(8)
            .opacity(0.3)
    }
}
