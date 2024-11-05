//
//  NavigationBarView.swift
//  StutterQuest
//
//  Created by Omar Bahzad on 11/1/24.
// Help with AI

import SwiftUI

// Navigation bar with four icons
struct NavigationBarView: View {
    var body: some View {
        VStack(spacing: 30) {
            Button(action: {
                print("Home button tapped")
            }) {
                Image(systemName: "house.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding()
            }
            
            Button(action: {
                print("Leaderboard button tapped")
            }) {
                Image(systemName: "list.number")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding()
            }
            
            Button(action: {
                print("Streaks button tapped")
            }) {
                Image(systemName: "flame.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding()
            }
            
            Button(action: {
                print("Settings button tapped")
            }) {
                Image(systemName: "gearshape.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding()
            }
        }
        .padding(.top, 20)
    }
}
