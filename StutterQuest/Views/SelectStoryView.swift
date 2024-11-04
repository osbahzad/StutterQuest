import SwiftUI

struct SelectStoryView: View {
    var body: some View {
        Text("Select Your Story")
            .font(.largeTitle)
            .padding()
            .navigationTitle("Story Selection")
            .navigationBarBackButtonHidden(true) // Hides the back button
    }
}
