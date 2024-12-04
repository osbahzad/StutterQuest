import SwiftUI

struct StoryView: View {
    @StateObject private var speechRecognizer = SpeechRecognizer()

    @State private var isTranscribing = false
    @State private var audioURL: String? = nil
    @State private var showSheet = false
    @State private var selectedWord: String? = nil
    @State private var currentPage = 0
    @State private var spokenText: String = ""
  
    @State private var isPaused = false
    @State private var isStoryCompleted = false
    
    
    private let pronunciationService = PronunciationService()
    @ObservedObject var authViewModel: AuthViewModel
  
    let story: Story
    var nickname: String
    var email: String
    var body: some View {
        ZStack {
            if isStoryCompleted {
                StoryCompletedView(
                    onHome: {
                        // Go back to home
                        if let window = UIApplication.shared.windows.first {
                            window.rootViewController = UIHostingController(rootView: StorySelectionView(nickname: nickname, email: email))
                            window.makeKeyAndVisible()
                        }
                    },
                    onRestart: {
                        currentPage = 0
                        isStoryCompleted = false
                        spokenText = ""
                        speechRecognizer.transcript = ""
                    }
                )
            } else {
                storyContent
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                pauseButton
            }
        }
        .navigationBarBackButtonHidden(true) // Hide back button
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showSheet, onDismiss: {
            spokenText = speechRecognizer.transcript
        }) {
            pronunciationSheet
        }
    }

    private var storyContent: some View {
        ZStack {
            if currentPage < story.images.count && currentPage < story.sentences.count {
                backgroundImage
                    .edgesIgnoringSafeArea(.all)
                    .offset(y: -50) // Shift background up
            }

            VStack {
                Spacer()

                transcriptionButton

                VStack {
                    if currentPage < story.sentences.count && currentPage < story.images.count {
                        let currentSentence = story.sentences[currentPage]
                        sentenceView(for: currentSentence)
                    }
                }
                .background(Color.white.opacity(0.85))
                .cornerRadius(10)

                previewPanels
                    .frame(height: UIScreen.main.bounds.height * 0.25)
            }

            navigationButtons

            if isPaused {
                pausedOverlay // Display paused page
            }
        }
    }

    private var backgroundImage: some View {
        Group {
            if let url = URL(string: story.images[currentPage]) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                            .clipped()
                    case .failure:
                        Text("Failed to load image")
                            .foregroundColor(.gray)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    @unknown default:
                        EmptyView()
                    }
                }
            }
        }
    }

    private var previewPanels: some View {
        PreviewPanelView(story: story, currentPage: currentPage) { selectedPage in
            currentPage = selectedPage
            spokenText = ""
            speechRecognizer.transcript = ""
        }
        .frame(height: UIScreen.main.bounds.height * 0.25)
    }

    private var navigationButtons: some View {
        HStack {
            Button(action: {
                if currentPage > 0 {
                    currentPage -= 1
                    spokenText = ""
                    speechRecognizer.transcript = ""
                }
            }) {
                Image(systemName: "chevron.left.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.orange)
            }

            Spacer()

            Button(action: {
                if currentPage < story.sentences.count - 1 {
                    currentPage += 1
                    spokenText = ""
                    speechRecognizer.transcript = ""
                } else {
                    isStoryCompleted = true // Mark story as completed
                  Task {
                    await authViewModel.update_completed_stories(email: email, story: story)
                  }
                }
            }) {
                Image(systemName: "chevron.right.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.green)
            }
        }
        .padding(.horizontal, 40)
        .padding(.top, 10)
    }

    private var pauseButton: some View {
        Button(action: {
            isPaused.toggle()
        }) {
            Image(systemName: "pause.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.white)
                .padding(.top)
        }
    }

    private var pausedOverlay: some View {
        ZStack {
            Color.black.opacity(0.6)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                Text("PAUSED")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                HStack(spacing: 40) {
                    Button(action: {
                        // Navigate back to home (StorySelectionView)
                        if let window = UIApplication.shared.windows.first {
                          window.rootViewController = UIHostingController(rootView: StorySelectionView(nickname: nickname, email: email))
                            window.makeKeyAndVisible()
                        }
                    }) {
                        Image(systemName: "house.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }

                    Button(action: {
                        currentPage = 0 // Restart the story
                        isPaused = false
                    }) {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }

                    Button(action: {
                        // Placeholder for settings
                    }) {
                        Image(systemName: "gearshape.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }

    private var transcriptionButton: some View {
        Button(action: {
            isTranscribing.toggle()
            if isTranscribing {
                speechRecognizer.startTranscribing()
            } else {
                speechRecognizer.stopTranscribing()
                spokenText = speechRecognizer.transcript
            }
        }) {
            Text(isTranscribing ? "Stop Transcribing" : "Start Transcribing")
                .padding()
                .background(isTranscribing ? Color.red : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding(.top)
    }

    private var pronunciationSheet: some View {
        VStack {
            HStack {
                Spacer()
                Button("Close") {
                    showSheet = false
                }
                .padding()
            }
            if let audioURL = audioURL {
                WebView(urlString: audioURL)
                    .edgesIgnoringSafeArea(.all)
            } else {
                Text("No pronunciation available")
            }
        }
    }

    private func sentenceView(for currentSentence: String) -> some View {
        HStack {
            ForEach(TextComparison.colorizeText(spokenText: spokenText, targetText: currentSentence)) { word in
                Text(word.text + " ")
                    .foregroundColor(word.color)
                    .onTapGesture {
                        if word.color == .red {
                            selectedWord = word.strippedText
                            Task { await fetchPronunciation(for: word.strippedText) }
                        }
                    }
            }
        }
        .padding()
    }

    private func fetchPronunciation(for word: String) async {
        audioURL = nil
        showSheet = false

        let url = await pronunciationService.fetchPronunciation(for: word)

        if let validURL = url {
            audioURL = validURL
            showSheet = true
        }
    }
}

