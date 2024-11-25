//
//  AuthViewModel.swift
//  StutterQuest
//
//  Created by Veronica Benedict on 11/3/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine



class AuthViewModel: ObservableObject {
  @Published var user: User?
  @Published var errorMessage: String?
  @Published var currentSession: String?
  @Published var signedIn: Bool = true
  
  private var db = Firestore.firestore()
  
  func signUp(email: String, password: String) async {
    do {
      print("attempting to sign up with email \(email) and password: \(password)")
      let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
      let uid = authResult.user.uid
      print("uid: ", uid)
      let newUser = User(user_id: uid,
                        nickname: "",
                        email: email,
                        password: password,
                        num_stories_read: 0,
                        num_streak_days: 0,
                        num_hours_played: 0,
                        rank: 0)
      try await db.collection("user").document(uid).setData([
        "user_id": newUser.user_id,
        "nickname": newUser.nickname,
        "email": newUser.email,
        "num_stories_read": newUser.num_stories_read,
        "num_streak_days": newUser.num_streak_days,
        "num_hours_played": newUser.num_hours_played,
//        "completed_stories": newUser.completed_stories.map { $0.id.uuidString },
//        "purchased_stories": newUser.purchased_stories.map { $0.id.uuidString }, s
        "rank": newUser.rank
      ])
      
      await save_login_time(uid: uid)
      
      DispatchQueue.main.async {
        self.user = newUser
      }
      print("user has signed up with email: \(email)")
    } catch let error as NSError {
      DispatchQueue.main.async {
        if let errorCode = AuthErrorCode(rawValue: error.code) {
              switch errorCode {
              case .emailAlreadyInUse:
                  self.errorMessage = "The email is already in use."
              default:
                  self.errorMessage = error.localizedDescription
              }
          } else {
              self.errorMessage = error.localizedDescription
          }
          print("Error occurred: \(self.errorMessage ?? "Unknown error")")
      }
    }
  }
  
  func signIn(email:String, password: String) async {
    do {
      print("attempting to sign in with email: \(email) and password: \(password)")
      let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
      let user_id = authResult.user.uid
      
      await save_login_time(uid: user_id)
      
      let document = try await db.collection("user").document(user_id).getDocument()
      if let data = document.data() {
        let fetchedUser = User(
          user_id: data["user_id"] as? String ?? "",
          nickname: data["nickname"] as? String ?? "",
          email: data["email"] as? String ?? "",
          password: password,
          num_stories_read: data["num_stories_read"] as? Int ?? 0,
          num_streak_days: data["num_streak_days"] as? Int ?? 0,
          num_hours_played: data["num_hours_played"] as? Int ?? 0,
          rank: data["rank"] as? Int ?? 0
        )
        DispatchQueue.main.async {
          self.user = fetchedUser
//          self.currentSession = sessionId
          print("current session: ", self.currentSession ?? "")
        }
      }
      print("user has signed in with email: \(email)")
    } catch let error as NSError {
      DispatchQueue.main.async {
        print(AuthErrorCode(rawValue: error.code)!)
        switch error.localizedDescription {
        case "The supplied auth credential is malformed or has expired.":
            self.errorMessage = "Invalid email/password"
        default:
            self.errorMessage = "An unknown error occurred."
        }
        print("Error occurred: \(self.errorMessage ?? "Unknown error")")
      }
    }
  }
  
  func logout(email: String) async {
    do {
      let user_id = try await db.collection("user").whereField("email", isEqualTo: email).getDocuments().documents.first?.data()["user_id"] as? String
      let currentSession = (await find_most_recent_login(uid: user_id!))!
      try await db.collection("user").document(user_id!).collection("sessions").document(currentSession).updateData(["logout_date": Date()])
      await UserDataViewModel().update_hours_read(userID: user_id!)
      try Auth.auth().signOut()
      DispatchQueue.main.async {
        self.user = nil
        self.currentSession = nil
        self.signedIn = false
        print("user has signed out")
      }
    } catch {
      print("failed to sign out")
    }
  }
  
  func save_nickname(userID: String, nickname: String) async {
    do {
      try await db.collection("user").document(userID).updateData(["nickname": nickname])
      
      print("user's nickname has been updated to: \(nickname)")
    } catch let error {
      DispatchQueue.main.async {
        self.errorMessage = error.localizedDescription
      }
      print("error: \(String(describing: self.errorMessage))")
    }
  }
  
  func save_login_time(uid: String) async {
    do {
      let sessionId = UUID().uuidString
      let today = Date()
      
      try await db.collection("user").document(uid).collection("sessions").document(sessionId).setData([
        "login_date": today
      ])
      await UserDataViewModel().update_day_streak(userID: uid)
      
    } catch {
      print("failed to save login time")
    }
  }
  
  func find_most_recent_login(uid: String) async -> String? {
    do {
      let sessions = try await db.collection("user").document(uid).collection("sessions").getDocuments()
      var mostRecentSession: String?
      var mostRecentDate: Date?
        
      for session in sessions.documents {
        if let date = session.data()["login_date"] as? Timestamp {
          let loginDate = date.dateValue()
          if mostRecentDate == nil || loginDate > mostRecentDate! {
            mostRecentDate = loginDate
            mostRecentSession = session.documentID
          }
        }
      }
          return mostRecentSession
    } catch {
      
      print("failed to find most recent login")
      return nil
    }

  }
}


