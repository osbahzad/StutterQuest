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
    @State private var currentSentenceIndex = 0

    private let pronunciationService = PronunciationService()
    let sentences: [String]

    var body: some View {
        VStack(spacing: 20) {
            // Check if the current sentence index is within range
            if currentSentenceIndex < sentences.count {
                let currentSentence = sentences[currentSentenceIndex]

                // Display color-coded target text with tap gesture on mispronounced words
                HStack {
                    ForEach(TextComparison.colorizeText(spokenText: speechRecognizer.transcript, targetText: currentSentence)) { word in
                        Text(word.text + " ")
                            .foregroundColor(word.color)
                            .onTapGesture {
                                if word.color == .red {
                                    selectedWord = word.strippedText
                                    Task {
                                        await fetchPronunciation(for: word.strippedText)
                                    }
                                }
                            }
                    }
                }
                .padding()

//                // Display live transcript for demo purposes
//                Text("Transcript: \(speechRecognizer.transcript)")
//                    .padding()
//                    .frame(maxWidth: .infinity, minHeight: 100, alignment: .topLeading)
//                    .background(Color(UIColor.systemGray6))
//                    .cornerRadius(10)
//                    .padding()

                // Buttons in the same row
                HStack {
                    // "Back" button to move to the previous sentence
                    Button(action: {
                        if currentSentenceIndex > 0 {
                            currentSentenceIndex -= 1
                            speechRecognizer.transcript = "" // Reset the transcript for the previous sentence
                        }
                    }) {
                        Text("Back")
                            .font(.headline)
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    Spacer() // Adds space between the buttons

                    // "Start Transcribing" button
                    Button(action: {
                        isTranscribing.toggle()
                        if isTranscribing {
                            speechRecognizer.startTranscribing()
                        } else {
                            speechRecognizer.stopTranscribing()
                        }
                    }) {
                        Text(isTranscribing ? "Stop Transcribing" : "Start Transcribing")
                            .padding()
                            .background(isTranscribing ? Color.red : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    Spacer() // Adds space between the buttons

                    // "Next" button to move to the next sentence
                    Button(action: {
                        if currentSentenceIndex < sentences.count - 1 {
                            currentSentenceIndex += 1
                            speechRecognizer.transcript = "" // Reset the transcript for the new sentence
                        }
                    }) {
                        Text("Next")
                            .font(.headline)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
            } else {
                Text("End of story")
                    .font(.headline)
                    .padding()
            }
        }
        .padding()
        // Show sheet with WebView for pronunciation audio
        .sheet(isPresented: $showSheet) {
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
    }

    private func fetchPronunciation(for word: String) async {
        let url = await pronunciationService.fetchPronunciation(for: word)
        
        // Ensure audioURL and showSheet are updated correctly
        self.audioURL = url
        self.showSheet = url != nil
        
        // Print the audio URL for debugging
        if let audioURL = url {
            print("Audio URL for '\(word)': \(audioURL)")
        } else {
            print("No audio URL available for '\(word)'")
        }
    }
}

