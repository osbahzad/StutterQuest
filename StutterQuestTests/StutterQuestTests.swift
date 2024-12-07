//
//  StutterQuestTests.swift
//  StutterQuestTests
//
//  Created by Omar Bahzad on 10/28/24.
//

import XCTest
@testable import StutterQuest

final class StutterQuestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

  func testStoryDetails() throws {
    let story = Story(completed: false, images:["image1", "image2"], pageNum: 10, purchasable: true, storyDescription: "test story", storyName: "test name", storyPreviewImage: "image1", sentences: ["abc", "def"])
    XCTAssertEqual(story.completed, false)
    XCTAssertEqual(story.images, ["image1", "image2"])
    XCTAssertEqual(story.pageNum, 10)
    XCTAssertEqual(story.purchasable, true)
    XCTAssertEqual(story.storyDescription, "test story")
    XCTAssertEqual(story.storyName, "test name")
    XCTAssertEqual(story.storyPreviewImage, "image1")
  }
  
  func testRetrievalStoryDetails() throws {
    
  }

}
