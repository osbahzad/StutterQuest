//
//  StoryRepositoryTests.swift
//  StutterQuestTests
//
//  Created by Veronica Benedict on 11/18/24.
//

import XCTest
import Firebase
import FirebaseFirestore
@testable import StutterQuest

final class StoryRepositoryTests: XCTestCase {
    var repository: StoryRepository!
    var firestore: Firestore!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    repository = StoryRepository()
    firestore = Firestore.firestore()
  }

    override func tearDownWithError() throws {
      repository = nil
      firestore = nil
      try super.tearDownWithError()
    }

  func testGetStories() async {
    let expectation = XCTestExpectation(description: "Stories retrieved")
    
    repository.$stories
      .sink { stories in
        if !stories.isEmpty {
          XCTAssertGreaterThan(stories.count, 0)
          XCTAssertNotNil(stories[0].id)
          expectation.fulfill()
        }
      }
//      .store(in: &repository.cancellables)
//    repository.get()
    
    await fulfillment(of: [expectation], timeout: 5.0)
    
  }

}
