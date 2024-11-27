//
//  StoryCompletedView.swift
//  StutterQuest
//
//  Created by Wenchao Hu on 11/6/24.
//

import SwiftUI

struct StoryCompletedView: View {
    var onHome: () -> Void
    var onRestart: () -> Void

    var body: some View {
        VStack(spacing: 30) {
            Text("🎉 Story Completed 🎉")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(.orange)
            
            Text("Great job finishing the story!")
                .font(.title3)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            HStack(spacing: 40) {
                Button(action: onHome) {
                    VStack {
                        Image(systemName: "house.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .clipShape(Circle())
                        
                        Text("Home")
                            .foregroundColor(.blue)
                    }
                }
                
                Button(action: onRestart) {
                    VStack {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .clipShape(Circle())
                        
                        Text("Restart")
                            .foregroundColor(.green)
                    }
                }
            }
        }
        .padding()
        .background(
            Color(UIColor.secondarySystemBackground)
                .edgesIgnoringSafeArea(.all)
        )
    }
}
