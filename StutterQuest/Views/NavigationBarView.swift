import SwiftUI

struct NavigationBarView: View {
    var email: String
    var nickname: String

    var body: some View {
        VStack(spacing: 30) {
            // Navigation to Home
            NavigationLink(destination: StorySelectionView(nickname: nickname, email: email)) {
                NavigationButton(iconName: "house.fill", label: "Home")
            }
            
            // Navigation to Leaderboard (Placeholder action)
            NavigationButton(iconName: "list.number", label: "Leaderboard")
            
            // Navigation to Streaks
            NavigationLink(destination: StreaksView(email: email, nickname: nickname)) {
                NavigationButton(iconName: "flame.fill", label: "Streaks")
            }
            
            // Navigation to Settings
            NavigationLink(destination: SettingsView()) {
                NavigationButton(iconName: "gearshape.fill", label: "Settings")
            }
        }
        .padding(10)
        .background(
            Color(UIColor.secondarySystemBackground)
                .cornerRadius(15)
                .shadow(radius: 3)
        )
        .frame(maxHeight: .infinity, alignment: .center) // Vertically center the navigation
        .padding(.trailing, 20)
    }
}

struct NavigationButton: View {
    var iconName: String
    var label: String

    var body: some View {
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


