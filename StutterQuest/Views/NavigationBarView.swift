import SwiftUI

struct NavigationBarView: View {
    var email: String
    var nickname: String
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Spacer()
                
                VStack(spacing: 30) {
                    NavigationLink(destination: StorySelectionView(nickname: nickname, email: email)) {
                      NavigationButton(iconName: "house.fill", label: "Home")
                    }
                    NavigationButton(iconName: "list.number", label: "Leaderboard")
                    NavigationLink(destination: StreaksView(email: email, nickname: nickname)) {
                      NavigationButton(iconName: "flame.fill", label: "Streaks")
                    }
                    NavigationButton(iconName: "gearshape.fill", label: "Settings")
                    NavigationButton(iconName: "house.fill", label: "Home") {
                        print("Home button clicked")
                        // Add navigation or action logic here
                    }
                    NavigationButton(iconName: "list.number", label: "Leaderboard") {
                        print("Leaderboard button clicked")
                        // Add navigation or action logic here
                    }
                    NavigationButton(iconName: "flame.fill", label: "Streaks") {
                        print("Streaks button clicked")
                        // Add navigation or action logic here
                    }
                    NavigationButton(iconName: "gearshape.fill", label: "Settings") {
                        print("Settings button clicked")
                        // Add navigation or action logic here
                    }
                }
                .padding(10)
                .background(
                    Color(UIColor.secondarySystemBackground)
                        .cornerRadius(15)
                        .shadow(radius: 3)
                )
                .frame(maxHeight: .infinity) // Ensure the VStack takes all available space
                .padding(.trailing, 20)
                .position(x: geometry.size.width - 20, // Adjust horizontal position
                          y: geometry.size.height / 2) // Vertically center the VStack
            }
            .edgesIgnoringSafeArea(.trailing)
        }
    }
}

struct NavigationButton: View {
    var iconName: String
    var label: String
    var action: () -> Void // Closure for button action

    var body: some View {
        Button(action: action) {
            VStack(spacing: 5) {
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
}



struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView()
            .frame(width: 100, height: 600) // Simulate screen height for preview
    }
}
