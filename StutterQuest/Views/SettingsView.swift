//
//  SettingsView.swift
//  StutterQuest
//
//  Created by Omar Bahzad on 12/6/24.
// Some hepl with AI

import SwiftUI

struct SettingsView: View {
    @State private var isMuted = false // State to track mute/unmute

    var body: some View {
        ZStack {
            // Background
            Image("login_background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
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


