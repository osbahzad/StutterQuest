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
  
  func fetch_nickname(email: String) async -> String?{
    do {
      let doc = try await db.collection("user").whereField("email", isEqualTo: email).getDocuments()
      return doc.documents.first?.data()["nickname"] as? String
    } catch {
      return nil
    }
  }
  
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
  
  func update_day_streak(userID: String) async {
    do {
      let sessionDocs = try await db.collection("user").document(userID).collection("sessions").getDocuments()
      print("sessionDocs: ", sessionDocs)
      let sessions = sessionDocs.documents.compactMap { doc -> Date? in
        let date = doc.data()["login_date"] as? Timestamp
        return date?.dateValue()
      }
      print("sessions: ", sessions)
      let sortedSessions = sessions.sorted()
      var streak = 0
      var lastDate: Date? = nil
      
      for session in sortedSessions {
        if let last = lastDate, Calendar.current.isDate(last, inSameDayAs: session.addingTimeInterval(-86400)) {
          streak += 1
        } else {
          streak = 1
        }
        lastDate = session
      }
      try await db.collection("user").document(userID).updateData(["num_streak_days": streak])
    } catch {
      print("failed to update streak days")
    }
  }
  
  func update_hours_read(userID: String) async {
    do {
      let sessionDocs = try await db.collection("user").document(userID).collection("sessions").getDocuments()
      var totalHours = 0
      for session in sessionDocs.documents {
        if let start = session.data()["login_date"] as? Timestamp, let end = session.data()["logout_date"] as? Timestamp {
          totalHours += Int(end.dateValue().timeIntervalSince(start.dateValue())) / 3600
        }
      }
      print("total hours: ", totalHours)
      try await db.collection("user").document(userID).updateData(["num_hours_played": totalHours])
    } catch {
      print("failed to update hours read")
    }
  }
  
}
