//
//  TestView.swift
//  StutterQuest
//
//  Created by Omar Bahzad on 11/4/24.
//

// just for testing, the story selection didnt work

import Foundation
import SwiftUI

struct TestView: View {
    var body: some View {
        NavigationView {
            NavigationLink(
                destination: Text("This is the destination view"),
                label: {
                    Text("Tap me to navigate")
                }
            )
        }
    }
}

