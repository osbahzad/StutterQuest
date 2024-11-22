//
//  UserDataViewModel.swift
//  StutterQuest
//
//  Created by Veronica Benedict on 11/20/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine

class UserDataViewModel: ObservableObject {
  
  @Published var num_hours_read: Int?
  @Published var num_days_read: Int?
  @Published var num_books_read: Int?
  private var db = Firestore.firestore()
  
  func fetch_num_hours_read(email: String) async -> Int {
    do {
      let doc = try await db.collection("user").whereField("email", isEqualTo: email).getDocuments()
      if let numHours = doc.documents.first?.data()["num_hours_played"] as? Int {
        DispatchQueue.main.async {
           self.num_hours_read = numHours
        }
        return numHours
      }
      return 0
    } catch {
      print(error)
      return 0
    }
  }
  
  func fetch_num_days_read(email: String) async -> Int {
    do {
      let doc = try await db.collection("user").whereField("email", isEqualTo: email).getDocuments()
      if let numDays = doc.documents.first?.data()["num_streak_days"] as? Int {
        DispatchQueue.main.async {
          self.num_days_read = numDays
        }
        return numDays
      }
      return 0
    } catch {
      return 0

    }
  }
  
  func fetch_num_books_read(email: String) async -> Int{
    do {
      let doc = try await db.collection("user").whereField("email", isEqualTo: email).getDocuments()
      if let numBooks = doc.documents.first?.data()["num_stories_read"] as? Int {
        DispatchQueue.main.async {
          self.num_books_read = numBooks
        }
        return numBooks
      }
      return 0
    } catch {
      print(error)
      return 0
    }
  }
  
}
