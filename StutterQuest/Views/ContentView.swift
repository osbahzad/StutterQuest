//
//  ContentView.swift
//  StutterQuest
//
//  Created by Omar Bahzad on 10/28/24.
//

import SwiftUI

struct ContentView: View {
  @State private var signingUp = true
    var body: some View {
        VStack {
          CustomToggle(signingUp: $signingUp)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
