//
//  AuthViewTest.swift
//  StutterQuestTests
//
//  Created by Veronica Benedict on 11/18/24.
//

import XCTest
import Combine
import FirebaseAuth
import FirebaseFirestore
@testable import StutterQuest

final class AuthViewTest: XCTestCase {
  var viewModel: AuthViewModel!
  
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
      viewModel = AuthViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
      viewModel = nil
    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
  
  func testSignUp() async throws {
    let email = "test_auth@email.com"
    let password = "password"
    await viewModel.signUp(email: email, password: password)
    
    XCTAssertNotNil(Auth.auth().currentUser)
    
    try await Auth.auth().currentUser?.delete()
    
  }
  
  func testSignIn() async throws {
    let email = "text_auth2@email.com"
    let password = "password"
    await viewModel.signUp(email: email, password: password)
    try Auth.auth().signOut()
    
    await viewModel.signIn(email: email, password: password)
    
    XCTAssertEqual(Auth.auth().currentUser?.email, email)
    XCTAssertNotNil(Auth.auth().currentUser)
    
    try await Auth.auth().currentUser?.delete()
  }
  
  func testSaveNickname() async throws {
    let email = "test_auth14@email.com"
    let password = "password"
    await viewModel.signUp(email: email, password: password)
    let nickname = "test_nickname"
    await viewModel.save_nickname(userID: Auth.auth().currentUser!.uid, nickname: nickname)
    try await Firestore.firestore().collection("user").document(Auth.auth().currentUser!.uid).updateData(["nickname": nickname])
    let doc = try await Firestore.firestore().collection("user").whereField("email", isEqualTo: email).getDocuments()
    XCTAssertEqual(doc.documents.first?.data()["nickname"] as? String, nickname)
  }
  
  func testSignInFailure() async throws {
    let email = "text_auth5@email.com"
    let password = "password"
    await viewModel.signUp(email: email, password: password)
    try Auth.auth().signOut()
    
    await viewModel.signIn(email: email, password: "12")
    XCTAssertNil(Auth.auth().currentUser)
    await viewModel.signIn(email: email, password: password)
    try await Auth.auth().currentUser?.delete()
  }
  
  
  func testLogout() async throws {
    
    let email = "test_auth6@email.com"
    let password = "password"
    await viewModel.signUp(email: email, password: password)
    await viewModel.logout(email: email)
    XCTAssertNil(Auth.auth().currentUser)
    XCTAssertNil(viewModel.currentSession)
    await viewModel.signIn(email: email, password: password)
    try await Auth.auth().currentUser?.delete()
  }
  

  
  func testSaveLoginTime() async throws {
    let email = "test_auth20@email.com"
    let password = "password"
    await viewModel.signUp(email: email, password: password)
    await viewModel.save_login_time(uid: Auth.auth().currentUser!.uid)
    let doc = try await Firestore.firestore().collection("user").document(Auth.auth().currentUser!.uid).collection("sessions").getDocuments()
    XCTAssertFalse(doc.isEmpty)
  }
  
  func testFetchCompletedStories() async throws {
    let email = "veronica55@email.com"
    let password = "password"
    await viewModel.signIn(email: email, password: password)
    let doc = try await Firestore.firestore().collection("user").whereField("email", isEqualTo: email).getDocuments()
    let completedStories = doc.documents.first?.data()["completed_stories"] as? [String]
    let fetchedCompletedStories = await viewModel.fetch_completed_stories(email: email)
    XCTAssertEqual(completedStories, fetchedCompletedStories)
  }
  
  
  func testFindMostRecentLogin() async {
    let email = "test123@email.com"
    let password = "password"
    await viewModel.signUp(email: email, password: password)
    let sessionsRef = Firestore.firestore().collection("user").document(Auth.auth().currentUser!.uid).collection("sessions")
    let earlierSession = [
      "login_date": Timestamp(date: Date(timeIntervalSinceNow: -3600)) // 1 hour ago
    ]
    let laterSession = [
      "login_date": Timestamp(date: Date()) // current time
    ]
    
    
    // Add sessions to Firestore
    try? await sessionsRef.document("session1").setData(earlierSession)
    try? await sessionsRef.document("session2").setData(laterSession)
    
    // Call the method to find the most recent login
    let mostRecentSession = await viewModel.find_most_recent_login(uid: Auth.auth().currentUser!.uid)
    
    // Verify that the most recent session's document ID is "session2"
    XCTAssertEqual(mostRecentSession, "session2")
  }
  
  func testFindMostRecentFail() async {
    let mostRecentSession = await viewModel.find_most_recent_login(uid: "nonexistent")
    XCTAssertEqual(mostRecentSession, nil)
  }
  
  
  
  
  
    
}

