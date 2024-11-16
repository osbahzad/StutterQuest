//
//  NavigationBarView.swift
//  StutterQuest
//
//  Created by Omar Bahzad on 11/1/24.
// Help with AI

import SwiftUI

struct NavigationBarView: View {
    var body: some View {
        HStack {
            Spacer()
            
            VStack(spacing: 30) {
                NavigationButton(iconName: "house.fill", label: "Home")
                NavigationButton(iconName: "list.number", label: "Leaderboard")
                NavigationButton(iconName: "flame.fill", label: "Streaks")
                NavigationButton(iconName: "gearshape.fill", label: "Settings")
            }
            .padding(10) 
            .background(
                Color(UIColor.secondarySystemBackground)
                    .cornerRadius(15)
                    .shadow(radius: 3)
            )
            .padding(.trailing, 20)
        }
        .edgesIgnoringSafeArea(.trailing)
    }
}

struct NavigationButton: View {
    var iconName: String
    var label: String
    
    var body: some View {
        VStack(spacing: 5) { // Added spacing between icon and label
            Image(systemName: iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .foregroundColor(Color(red: 0.42, green: 0.55, blue: 0.49))
            
            Text(label)
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }
}

struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView()
    }
}
