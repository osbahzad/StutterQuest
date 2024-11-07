//
//  StoryView.swift
//  StutterQuest
//
//  Created by Omar Bahzad on 10/30/24.
// Help with AI

import SwiftUI

struct StoryView: View {
    @StateObject private var speechRecognizer = SpeechRecognizer()
    @State private var isTranscribing = false
    @State private var audioURL: String? = nil
    @State private var showSheet = false
    @State private var selectedWord: String? = nil
    @State private var currentPage = 0
    @State private var currentSet = 0
    @State private var spokenText: String = "" // Track spoken text progress

    private let pronunciationService = PronunciationService()
    let story: Story

    var body: some View {
        ZStack {
            // MARK: - Background Image
            if currentPage < story.images.count && currentPage < story.sentences.count {
                backgroundImage
                    .edgesIgnoringSafeArea(.all)
            }

            VStack {
                Spacer() // Push everything down

                // MARK: - Text Container with Sentence and Button
                VStack {
                    if currentPage < story.sentences.count && currentPage < story.images.count {
                        let currentSentence = story.sentences[currentPage]
                        
                        // Sentence with color-coded words
                        sentenceView(for: currentSentence)

                        // "Start Transcribing" button
                        transcriptionButton
                    }
                }
                .background(Color.white)
                .cornerRadius(10)
                .padding([.horizontal, .bottom])
                .frame(height: UIScreen.main.bounds.height / 3)

                // MARK: - Preview Panels (at the bottom)
                previewPanels
                    .frame(height: UIScreen.main.bounds.height * 0.25)
            }

            // MARK: - Navigation Buttons (Left and Right Arrows)
            navigationButtons
        }
        .padding()
        
        // Show sheet with WebView for pronunciation audio
        .sheet(isPresented: $showSheet, onDismiss: {
            spokenText = speechRecognizer.transcript // Update spoken text on sheet dismissal
        }) {
            pronunciationSheet
        }
        .navigationTitle(story.storyName)
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Sentence View (with color-coded words)
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

    // MARK: - Transcription Button
    private var transcriptionButton: some View {
        Button(action: {
            isTranscribing.toggle()
            if isTranscribing {
                speechRecognizer.startTranscribing()
            } else {
                speechRecognizer.stopTranscribing()
                spokenText = speechRecognizer.transcript // Preserve spoken text when stopping
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

    // MARK: - Background Image
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

    // MARK: - Preview Panels
    private var previewPanels: some View {
        VStack {
            Spacer()
            ZStack {
                Rectangle()
                    .fill(Color.black)
                    .frame(height: 100)
                    .edgesIgnoringSafeArea(.bottom)

                HStack(spacing: 10) {
                    ForEach(0..<5) { index in
                        let imageIndex = currentSet * 5 + index
                        if imageIndex < story.images.count {
                            previewImage(for: imageIndex)
                        } else {
                            placeholderImage
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }

    // MARK: - Preview Image
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

    // MARK: - Placeholder Image
    private var placeholderImage: some View {
        Color.gray
            .frame(width: 60, height: 60)
            .cornerRadius(8)
            .opacity(0.3)
    }

    // MARK: - Navigation Buttons
    private var navigationButtons: some View {
        VStack {
            HStack {
                // "Back" button
                Button(action: {
                    if currentPage > 0 {
                        currentPage -= 1
                        spokenText = ""
                        speechRecognizer.transcript = ""
                    }
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                        .background(Color.orange)
                        .cornerRadius(20)
                }
                .padding(.leading, 20)

                Spacer()

                // "Next" button
                Button(action: {
                    if currentPage < story.sentences.count - 1 {
                        currentPage += 1
                        spokenText = ""
                        speechRecognizer.transcript = ""
                    }
                }) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                        .background(Color.green)
                        .cornerRadius(20)
                }
                .padding(.trailing, 20)
            }
            .padding(.horizontal)
        }
    }

    // MARK: - Pronunciation Sheet
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

    // MARK: - Fetch Pronunciation
    private func fetchPronunciation(for word: String) async {
        audioURL = nil
        showSheet = false
        
        let url = await pronunciationService.fetchPronunciation(for: word)
        
        if let validURL = url {
            audioURL = validURL
            showSheet = true
            print("Audio URL for '\(word)': \(validURL)") // Debug print
        } else {
            print("No audio URL available for '\(word)'")
        }
    }
}
