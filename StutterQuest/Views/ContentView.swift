//
//  ContentView.swift
//  StutterQuest
//
//  Created by Omar Bahzad on 10/28/24.
//

import SwiftUI

struct ContentView: View {
  //  Loading Screen
  @State private var isLoading = true
  
  // Viewmodel
  @ObservedObject var storySelectionViewModel = StorySelectionViewModel()
  
  

  var body: some View {
    
    Group {
      if isLoading {
        Loading() // Show Loading screen while loading
      } else {
        SelectStoryView(storySelectionViewModel: storySelectionViewModel)
      }
    }.onAppear {
      // Simulate a loading delay
      DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        withAnimation {
          isLoading = false
        }
      }
    }
    
  }
}
 
