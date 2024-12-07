//
//  BackgroundMusicPlayer.swift
//  StutterQuest
//
//  Created by Omar Bahzad on 10/28/24.
//  Some help with AI

import Foundation
import AVFoundation

class BackgroundMusicPlayer {
    static let shared = BackgroundMusicPlayer()
    private var audioPlayer: AVAudioPlayer?

    private init() {}

    func playMusic(filename: String, fileType: String = "mp3") {
        guard let url = Bundle.main.url(forResource: filename, withExtension: fileType) else {
            print("Background music file not found")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1 // Infinite loop
            audioPlayer?.volume = 0.1 // Set desired volume level
            audioPlayer?.play()
        } catch {
            print("Error playing background music: \(error.localizedDescription)")
        }
    }

    func stopMusic() {
        audioPlayer?.stop()
    }

    func pauseMusic() {
        audioPlayer?.pause()
    }

    func resumeMusic() {
        audioPlayer?.play()
    }

    func setVolume(_ volume: Float) {
        audioPlayer?.volume = volume
    }
}
