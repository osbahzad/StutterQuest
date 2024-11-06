//
//  StoryCompletedView.swift
//  StutterQuest
//
//  Created by Wenchao Hu on 11/6/24.
//

import SwiftUI

struct StoryCompletedView: View { 

    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 10) {
                Image(systemName: "star.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.yellow)
                
                Text("Story Completed!")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.purple)
                
                Text("Thank you for reading!")
                    .font(.title3)
                    .foregroundColor(.secondary)
            }
            .padding() 
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(20)
        .padding()
    }
}
