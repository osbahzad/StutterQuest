//
//  StutterQuestApp.swift
//  StutterQuest
//
//  Created by Omar Bahzad on 10/28/24.
//


import SwiftUI
import Firebase
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct StutterQuestApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    

    var body: some Scene {
        WindowGroup {
          ContentView() 
//            TutorialView(onComplete: () -> Void)
        }
    }
}

