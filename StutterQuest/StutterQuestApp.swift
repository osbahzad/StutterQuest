//
//  StutterQuestApp.swift
//  StutterQuest
//
//  Created by Omar Bahzad on 10/28/24.
//  Some help with AI
//

import SwiftUI
import Firebase
import FirebaseCore
import AVFoundation

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        BackgroundMusicPlayer.shared.playMusic(filename: "background_music") // Moved here from ContentView
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Pause music when the app goes to the background
        BackgroundMusicPlayer.shared.pauseMusic()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Resume music when the app becomes active
        BackgroundMusicPlayer.shared.resumeMusic()
    }
}

@main
struct StutterQuestApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
            // Removed onAppear and onDisappear blocks for music here
        }
    }
}
