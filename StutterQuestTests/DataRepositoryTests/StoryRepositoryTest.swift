//
//  StoryRepositoryTest.swift
//  StutterQuestTests
//
//  Created by Veronica Benedict on 12/6/24.
//

import Foundation
import Combine
import XCTest
import FirebaseFirestore
@testable import StutterQuest

class StoryRepositoryTest: XCTest {
  var storyRepository: StoryRepository!
  var cancellables: Set<AnyCancellable> = []
  
  override func setUp() {
    super.setUp()
    
    storyRepository = StoryRepository()
    cancellables = []
  }
  
  override func tearDown() {
    
    cancellables = []
    storyRepository = nil
    super.tearDown()
  }
  
  func testGet() {
    let expectation = XCTestExpectation(description: "Firestore fetches data")
    let testStory = ["id": "1", "title": "Story 1"]
    Firestore.firestore().collection("story").addDocument(data: testStory) { error in
                if let error = error {
                    XCTFail("Failed to add document: \(error.localizedDescription)")
                    expectation.fulfill() // Fulfill expectation to avoid timeout if adding fails
                    return
                }
            }
//    Firestore.firestore().collection("story").addDocument(data: testStory)
    storyRepository.$stories
                .sink { stories in
                    print("Sink triggered with stories: \(stories)") // Debug log
                    if !stories.isEmpty {
                        XCTAssertEqual(stories.count, 1)
                        XCTAssertEqual(stories.first?.id, "1")
                        XCTAssertEqual(stories.first?.storyName, "Story 1")
                        expectation.fulfill()
                    }
                }
                .store(in: &cancellables)

            // Trigger Firestore listener to start fetching data
            storyRepository.get()
    wait()
    
  }
  
}

