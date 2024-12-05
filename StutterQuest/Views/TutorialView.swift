//
//  TutorialView.swift
//  StutterQuest
//
//  Created by Omar Bahzad on 11/20/24.
//  Some help with AI

import SwiftUI
import AVKit

struct TutorialView: View {
    var onComplete: () -> Void

    @State private var currentStep = 0
    @State private var player: AVPlayer? = nil // Track the AVPlayer instance
    @State private var videoAspectRatio: CGFloat = 16 / 9 // Default aspect ratio for the video

    private let tutorialSteps: [TutorialStep] = [
        TutorialStep(videoName: "1", description: "Swipe through the stories to navigate."),
        TutorialStep(videoName: "2", description: "Tap on a story to start it."),
        TutorialStep(videoName: "3", description: "Tap 'Start Transcribing' to start reading out loud."),
        TutorialStep(videoName: "4", description: "Tap 'Stop Transcribing' to stop reading."),
        TutorialStep(videoName: "5", description: "Tap on red words to hear their pronunciation."),
        TutorialStep(videoName: "6", description: "Tap the right arrow to go to the next page."),
    ]

    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                if let player = player {
                    VideoPlayer(player: player)
                        .aspectRatio(videoAspectRatio, contentMode: .fit) // Match video aspect ratio
                        .frame(width: UIScreen.main.bounds.width * 0.95)
                        .cornerRadius(10)
                        .disabled(true) // Disable interaction with the video
                } else {
                    Text("Loading video...")
                        .frame(width: UIScreen.main.bounds.width * 0.95, height: UIScreen.main.bounds.height * 0.6)
                        .cornerRadius(10)
                }

                // Transparent overlay to block interaction
                Color.clear
                    .frame(width: UIScreen.main.bounds.width * 0.95)
                    .allowsHitTesting(false)
            }

            // Tutorial Description with white background
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(radius: 5)

                Text(tutorialSteps[currentStep].description)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.15) // Adjust height to fit description

            // Navigation Buttons
            HStack(spacing: 20) {
                // Back Button
                Button(action: {
                    if currentStep > 0 {
                        currentStep -= 1
                        loadVideo()
                    }
                }) {
                    Text("Back")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(currentStep > 0 ? Color.orange : Color.gray)
                        .cornerRadius(10)
                }
                .disabled(currentStep == 0)

                // Next Button
                Button(action: {
                    if currentStep < tutorialSteps.count - 1 {
                        currentStep += 1
                        loadVideo()
                    } else {
                        onComplete()
                    }
                }) {
                    Text(currentStep < tutorialSteps.count - 1 ? "Next" : "Finish")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .frame(maxHeight: UIScreen.main.bounds.height * 0.1) // Adjust height for navigation
            .padding(.horizontal)
        }
        .padding(.bottom, 10) // Ensure there's space at the bottom
        .background(
            Image("nickname_background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        )
        .onAppear {
            resetTutorial()
        }
    }

    private func resetTutorial() {
        currentStep = 0
        loadVideo()
        print("Tutorial reset to step 0")
    }

    private func loadVideo() {
        let videoName = tutorialSteps[currentStep].videoName
        if let url = Bundle.main.url(forResource: videoName, withExtension: "mov") {
            player = AVPlayer(url: url)
            updateAspectRatio(for: url) // Update aspect ratio dynamically
            player?.play() // Automatically start playing the video
            print("Playing video: \(videoName)")
        } else {
            player = nil
            print("Failed to load video: \(videoName)")
        }
    }

    private func updateAspectRatio(for url: URL) {
        let asset = AVAsset(url: url)
        guard let track = asset.tracks(withMediaType: .video).first else { return }
        let size = track.naturalSize.applying(track.preferredTransform)
        videoAspectRatio = abs(size.width / size.height)
        print("Updated aspect ratio: \(videoAspectRatio)")
    }
}




struct TutorialStep {
    let videoName: String
    let description: String
}
