//
//  SettingsView.swift
//  StutterQuest
//
//  Created by Omar Bahzad on 12/6/24.
// Some help with AI
import SwiftUI

struct SettingsView: View {
    @State private var isMuted = false // State to track mute/unmute
    @Environment(\.dismiss) var dismiss // Add this to allow dismissal of the sheet

    var body: some View {
        ZStack {
            // Background
            Image("login_background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                HStack {
                    Spacer()
                    // Close button to dismiss the sheet
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                
                Text("Settings")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)

                Toggle(isOn: $isMuted) {
                    Text("Mute Background Music")
                        .font(.headline)
                }
                .toggleStyle(SwitchToggleStyle(tint: Color.blue))
                .padding()

                Spacer()
            }
            .padding()
            .onChange(of: isMuted) { newValue in
                if newValue {
                    BackgroundMusicPlayer.shared.setVolume(0)
                } else {
                    BackgroundMusicPlayer.shared.setVolume(0.1)
                }
            }
        }
    }
}
