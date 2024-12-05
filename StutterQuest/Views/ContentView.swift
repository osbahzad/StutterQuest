import SwiftUI

struct ContentView: View {
  @ObservedObject var authViewModel = AuthViewModel()
  @State private var signingUp = true
  @State private var email = ""
  @State private var password = ""
  @State private var nickname = ""
  @State private var signedIn = false
  @State private var showAlert = false
  @State private var alertMessage = ""
  @State private var usernameSaved = false
  @State private var isLoading = true // Loading state
  @State private var showTutorial = false // Track if the tutorial should be shown
  
  // Combined boolean for new user
  private var needNickname: Bool {
    return signingUp && signedIn
  }
  
  var body: some View {
    NavigationView {
      ZStack {
        if isLoading {
          LoadingView() // Show loading view first
            .transition(.opacity)
        } else if showTutorial {
          NavigationLink(destination: TutorialView(onComplete: {
            showTutorial = false
            signedIn = true
            UserDefaults.standard.set(true, forKey: "HasSeenTutorial")
          }), isActive: $showTutorial) {
            EmptyView()
          }
        } else {
          mainContentView // Show login/sign-up view after loading
        }
      }
      .onAppear {
        startLoadingProcess()
      }
    }
    .navigationBarBackButtonHidden(true)
  }
  
  // MARK: - Main Content View (Login/Sign-Up)
  private var mainContentView: some View {
    ZStack {
      // Background Image
      Image("login_background")
        .resizable()
        .scaledToFill()
        .edgesIgnoringSafeArea(.all)
      
      VStack {
        // Toggle between Sign Up and Sign In
        CustomToggle(signingUp: $signingUp)
        
        if signingUp {
          SignUpView(email: $email, password: $password)
        } else {
          SignInView(email: $email, password: $password)
        }
        
        // Continue Button
        Button(action: {
          showAlert = false
          alertMessage = ""
          Task {
            if signingUp {
              await authViewModel.signUp(email: email, password: password)
            } else {
              await authViewModel.signIn(email: email, password: password)
              nickname = await UserDataViewModel().fetch_nickname(email: email) ?? ""
            }
            if authViewModel.user != nil {
              signedIn = true
              if shouldShowTutorial() {
                showTutorial = true
              }
            }
            if let errorMessage = authViewModel.errorMessage {
              alertMessage = errorMessage
              showAlert = true
            }
          }
        }) {
          Text("Continue")
            .font(.system(size: 18, weight: .bold))
            .foregroundColor(.white)
            .frame(width: 200)
            .padding(.vertical, 10)
            .background(Color(red: 0.42, green: 0.55, blue: 0.49))
            .cornerRadius(15)
        }
        
        if showAlert {
          alertView
        }
      }
      
      // Navigation to next views
      backgroundNavigationLinks
    }
  }
  
  // MARK: - Alert View
  private var alertView: some View {
    GeometryReader { geometry in
      VStack {
        Spacer()
        RoundedRectangle(cornerRadius: 20)
          .foregroundColor(.white)
          .frame(width: 400, height: 150)
          .overlay(
            VStack(spacing: 20) {
              Text(alertMessage)
                .foregroundColor(.black)
              Button("Dismiss") {
                showAlert = false
              }
              .buttonStyle(.borderedProminent)
              .padding()
            }
              .padding()
          )
          .padding(.horizontal, 20)
          .offset(y: -150)
      }
      .frame(width: geometry.size.width, height: geometry.size.height)
      .transition(.opacity)
    }
  }
  
  // MARK: - Background Navigation Links
  private var backgroundNavigationLinks: some View {
    Group {
      if signingUp {
        NavigationLink(destination: SelectNicknameView(nickname: $nickname,email:email, username_saved: usernameSaved, authViewModel: authViewModel), isActive: .constant(needNickname)) {
          EmptyView()
        }
      } else {
        NavigationLink(destination: StorySelectionView(nickname: nickname, email: email), isActive: $signedIn) {
          EmptyView()
        }
      }
    }
  }
  
  
  // MARK: - Loading Process
  private func startLoadingProcess() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      withAnimation {
        isLoading = false
      }
    }
  }
  
  // MARK: - Check if Tutorial Should Be Shown
  private func shouldShowTutorial() -> Bool {
    return !UserDefaults.standard.bool(forKey: "HasSeenTutorial")
    //        return true
  }
}
