//
//  AuthViewTest.swift
//  StutterQuestTests
//
//  Created by Veronica Benedict on 11/18/24.
//

import XCTest
import FirebaseAuth
import FirebaseFirestore
@testable import StutterQuest

final class AuthViewTest: XCTestCase {
  var viewModel: AuthViewModel!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
  
  func testSignUp() async throws {
    let email = "test_auth@email.com"
    let password = "password"
    await viewModel.signUp(email: email, password: password)
    
    XCTAssertEqual(Auth.auth().currentUser?.email, email)
    XCTAssertNotNil(Auth.auth().currentUser)
    
    try await Auth.auth().currentUser?.delete()
    
  }
  
  func testSignIn() async throws {
    let email = "text_auth2@email.com"
    let password = "password"
    await viewModel.signUp(email: email, password: password)
    try await Auth.auth().signOut()
    
    await viewModel.signIn(email: email, password: password)
    
    XCTAssertEqual(Auth.auth().currentUser?.email, email)
    XCTAssertNotNil(Auth.auth().currentUser)
    
    try await Auth.auth().currentUser?.delete()
  }
  
  func testSaveNickname() async throws {
    let email = "test_auth3@email.com
    let password = "password"
    await viewModel.signUp(email: email, password: password)
    let nickname = "test_nickname"
    await viewModel.save_nickname(userID: viewModel.user!.user_id, nickname: nickname)
    let doc = try await Firestore.firestore().collection("users").document(viewModel.user!.user_id).getDocument()
    XCTAssertEqual(doc.data()?["nickname"] as! String, nickname)
    try await Auth.auth().currentUser?.delete()
  }
  
  func testFetchNickname() async throws {
    let email = "test_auth4@email.com"
    let password = "password"
    await viewModel.signUp(email: email, password: password)
    let nickname = "test_nickname"
    await viewModel.save_nickname(userID: viewModel.user!.user_id, nickname: nickname)
    let fetchedNickname = await viewModel.fetch_nickname(email: email)
    XCTAssertEqual(fetchedNickname, nickname)
    try await Auth.auth().currentUser?.delete()
    
  }
    
}
