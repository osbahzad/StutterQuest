//
//  UserDataViewModelTest.swift
//  StutterQuestTests
//
//  Created by Veronica Benedict on 12/6/24.
//

import XCTest
import Combine
import FirebaseAuth
import FirebaseFirestore
@testable import StutterQuest

class UserDataViewModelTest: XCTestCase {
  var viewModel: UserDataViewModel!
  override func setUpWithError() throws {
      // Put setup code here. This method is called before the invocation of each test method in the class.
    viewModel = UserDataViewModel()
  }

  override func tearDownWithError() throws {
      // Put teardown code here. This method is called after the invocation of each test method in the class.
    viewModel = nil
  }
  
  func testFetchNickname() async {
    let email = "veronica55@email.com"
    let nickname = await viewModel.fetch_nickname(email: email)
    XCTAssertNotNil(nickname)
    XCTAssertEqual(nickname, "Veronica")
  }
  
  func testFetchNicknameFail() async {
    let email = "veronica55"
    let nickname = await viewModel.fetch_nickname(email: email)
    XCTAssertNil(nickname)
  }
  
  func testFetchNumHoursRead() async {
    let email = "new@email.com"
    let password = "password"
    await AuthViewModel().signUp(email: email, password: password)
    let numHours = await viewModel.fetch_num_hours_read(email: email)
    XCTAssertNotNil(numHours)
    XCTAssertEqual(numHours, 0)
    
  }
  
  func testFetchNumHoursReadFail() async {
    let email = "newuser2"
    let numHours = await viewModel.fetch_num_hours_read(email: email)
    XCTAssertEqual(numHours, 0)
  }
  
  func testFetchNumDaysRead() async {
    do {
      let email = "new3@email.com"
      let password = "password"
      await AuthViewModel().signUp(email: email, password: password)
      let numHours = await viewModel.fetch_num_hours_read(email: email)
      XCTAssertNotNil(numHours)
      XCTAssertEqual(numHours, 0)
      try await  Firestore.firestore().collection("user").document(Auth.auth().currentUser!.uid).updateData(["num_streak_days": 5])
      let numHours2 = await viewModel.fetch_num_days_read(email: email)
      XCTAssertNotNil(numHours2)
      XCTAssertEqual(numHours2, 5)
      try await  Firestore.firestore().collection("user").document(Auth.auth().currentUser!.uid).updateData(["num_streak_days": 0])
    } catch {
      print(error)
    }
    
    
  }
  
  func testFetchNumBooksRead() async {
    do {
      let email = "newuser5@email.com"
      let password = "password"
      await AuthViewModel().signUp(email: email, password: password)
      let numBooks = await viewModel.fetch_num_books_read(email: email)
      XCTAssertNotNil(numBooks)
      XCTAssertEqual(numBooks, 0)
      try await  Firestore.firestore().collection("user").document(Auth.auth().currentUser!.uid).updateData(["num_stories_read": 5])
      let numBooks2 = await viewModel.fetch_num_books_read(email: email)
      XCTAssertNotNil(numBooks2)
      XCTAssertEqual(numBooks2, 5)
      try await  Firestore.firestore().collection("user").document(Auth.auth().currentUser!.uid).updateData(["num_stories_read": 0])
    } catch {
      print(error)
    }
  }
  
  func testFetchNumBooksReadFail() async {
    
    let email = "newuser6"
    let numBooks = await viewModel.fetch_num_books_read(email: email)
    XCTAssertEqual(numBooks, 0)
  }
  //used AI to generate
  func testUpdateDayStreak() async {
    let email = "newUser5@email.com"
    let password = "password"
    await AuthViewModel().signIn(email: email, password: password)
    let sessionsDoc = Firestore.firestore().collection("user").document(Auth.auth().currentUser!.uid).collection("sessions")
    let date1 = Date() // Current date
    let date2 = Date(timeIntervalSinceNow: -86400) // 1 day ago
    let date3 = Date(timeIntervalSinceNow: -172800) // 2 days ago
    let date4 = Date(timeIntervalSinceNow: -259200) // 3 days ago (non-consecutive)
    
    let session1 = [
        "login_date": Timestamp(date: date1)
    ]
    let session2 = [
        "login_date": Timestamp(date: date2)
    ]
    let session3 = [
        "login_date": Timestamp(date: date3)
    ]
    let session4 = [
        "login_date": Timestamp(date: date4)
    ]
    
    try? await sessionsDoc.document("session1").setData(session1)
    try? await sessionsDoc.document("session2").setData(session2)
    try? await sessionsDoc.document("session3").setData(session3)
    try? await sessionsDoc.document("session4").setData(session4)
    
    await viewModel.update_day_streak(userID: Auth.auth().currentUser!.uid)
    let numDays2 = await viewModel.fetch_num_days_read(email: email)
    XCTAssertGreaterThanOrEqual(numDays2, 1)
  }
  
  // used AI to generate
  func testUpdateHoursRead() async {
    let email = "testuser6@email.com"
    let password = "password"
    await AuthViewModel().signUp(email: email, password: password)
    let sessionsRef = Firestore.firestore().collection("user").document(Auth.auth().currentUser!.uid).collection("sessions")
    
    // Add test session data (start and end timestamps)
    let start1 = Date() // Current date
    let end1 = start1.addingTimeInterval(3600) // 1 hour later
    let start2 = Date(timeIntervalSinceNow: -7200) // 2 hours ago
    let end2 = start2.addingTimeInterval(5400) // 1.5 hours later
    
    let session1 = [
        "login_date": Timestamp(date: start1),
        "logout_date": Timestamp(date: end1)
    ]
    let session2 = [
        "login_date": Timestamp(date: start2),
        "logout_date": Timestamp(date: end2)
    ]
    
    // Add the sessions to Firestore
    try? await sessionsRef.document("session1").setData(session1)
    try? await sessionsRef.document("session2").setData(session2)

    // Call the update_hours_read function
    await viewModel.update_hours_read(userID: Auth.auth().currentUser!.uid)
    
    let numHours = await viewModel.fetch_num_hours_read(email: email)
    XCTAssertGreaterThanOrEqual(numHours, 2)
    
    
    
  }
  
  
}

