//
//  LoadingView.swift
//  StutterQuest
//
//  Created by Wenchao Hu on 11/7/24.
//

import SwiftUI

struct LoadingView: View {
    @State private var isAnimating = false
    @State private var progress = 0.0 // Tracks the progress of the loading bar

    var body: some View {
        ZStack {
            // Background Image
//            Image("backgroundImage")
//                .resizable()
//                .scaledToFill()
//                .ignoresSafeArea()
            
            VStack {
                Spacer()
                // Name
                Text("StutterQuest")
                .font(.title)
                .fontWeight(.bold)

                // Loading message for kids
                Text("Loading...")
                    .foregroundColor(.gray)
                    .padding(.top, 20)
                
                // Horizontal loading bar
                ProgressView(value: progress, total: 100)
                    .progressViewStyle(LinearProgressViewStyle(tint: Color.purple))
                    .frame(width: 200, height: 10)
                    .padding(.top, 10)
                    .onAppear {
                        // Simulate loading progress
                        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
                            progress += 1
                            if progress >= 100 {
                                timer.invalidate()
                            }
                        }
                    }

                Spacer()
            }
        }
    }
} 
