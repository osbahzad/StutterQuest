import SwiftUI

struct SelectStoryView: View {
    @ObservedObject var storySelectionViewModel = StorySelectionViewModel()

    var body: some View {
        VStack {
            Text("Select a Story")
                .font(.largeTitle)
                .padding()

            List(storySelectionViewModel.storyViewModels) { storyViewModel in
                VStack(alignment: .leading) {
                    // Story Name
                    Text(storyViewModel.story.storyName)
                        .font(.headline)

                    // Story Description
                    Text(storyViewModel.story.storyDescription)
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    // Completed Status
                    Text(storyViewModel.story.completed ? "Completed" : "Not Completed")
                        .font(.caption)
                        .foregroundColor(storyViewModel.story.completed ? .green : .red)

                    // Story Preview Image
                    if let url = URL(string: storyViewModel.story.storyPreviewImage) {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView() // Show loading indicator
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 100) // Adjust height as needed
                                    .cornerRadius(8)
                                    .padding(.top, 5)
                            case .failure:
                                Text("Failed to load image")
                                    .foregroundColor(.gray)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }  
                }
                .padding()
            }
        }
    }
}
