//
//  LockedStoryCardView.swift
//  StutterQuest
//
//  Created by Omar Bahzad on 11/25/24.
//  Some help wwith AI

import SwiftUI

struct LockedStoryCardView: View {
    @State private var showPurchasePopup = false // State to control the popup

    var body: some View {
        VStack {
            ZStack {
                // Blurred placeholder for the locked story
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 380, height: 180)
                    .blur(radius: 10) // Blur effect
                    .cornerRadius(10)
                    .overlay(
                        VStack {
                            Image(systemName: "lock.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                                .padding()

                            Text("Locked Story")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                    )

                // Button to purchase the locked story
                Button(action: {
                    showPurchasePopup = true
                }) {
                    Text("Purchase")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.top, 175) // Position the button below the image
                }
            }
        }
        .frame(width: 400, height: 250)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(15)
        .alert(isPresented: $showPurchasePopup) {
            Alert(
                title: Text("Purchase Locked Story"),
                message: Text("Do you want to purchase this story?"),
                primaryButton: .default(Text("Yes"), action: {
                    // Handle purchase logic here
                    print("Story purchased!")
                }),
                secondaryButton: .cancel()
            )
        }
    }
}

struct LockedStoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        LockedStoryCardView()
    }
}
