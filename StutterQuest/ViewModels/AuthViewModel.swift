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
  
  private var db = Firestore.firestore()
  
  func signUp(email: String, password: String) async {
    do {
      print("attempting to sign up")
      let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
      let uid = authResult.user.uid
      let newUser = User(user_id: UUID(uuidString: uid)!,
                        nickname: "",
                        email: email,
                        password: password,
                        num_stories_read: 0,
                        num_streak_days: 0,
                        num_hours_played: 0,
                        rank: 0)
      try await db.collection("users").document(uid).setData([
        "user_id": newUser.user_id.uuidString,
        "nickname": newUser.nickname,
        "email": newUser.email,
        "num_stories_read": newUser.num_stories_read,
        "num_streak_days": newUser.num_streak_days,
        "num_hours_played": newUser.num_hours_played,
//        "completed_stories": newUser.completed_stories.map { $0.id.uuidString },
//        "purchased_stories": newUser.purchased_stories.map { $0.id.uuidString }, s
        "rank": newUser.rank
      ])
      
      DispatchQueue.main.async {
        self.user = newUser
      }
      print("user has signed in with email: \(email)")
    } catch {
      DispatchQueue.main.async{
        self.errorMessage = error.localizedDescription
        print("Error occurred: \(self.errorMessage ?? "Unknown error")")

      }
    }
  }
  
  func signIn(email:String, password: String) async {
    do {
      print("attempting to sign in")
      let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
      let user_id = authResult.user.uid
      let document = try await db.collection("users").document(user_id).getDocument()
      if let data = document.data() {
        let fetchedUser = User(
          user_id: UUID(uuidString: data["user_id"] as? String ?? "") ?? UUID(),
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
        }
      }
      print("user has signed in with email: \(email)")
    } catch {
      DispatchQueue.main.async {
        self.errorMessage = error.localizedDescription
        print("Error occurred: \(self.errorMessage ?? "Unknown error")")
      
      }
    }
  }
}
