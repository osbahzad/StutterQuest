//
//  StoryModelTest.swift
//  StutterQuestTests
//
//  Created by Veronica Benedict on 11/14/24.
//

import XCTest
import FirebaseFirestore
import Firebase
@testable import StutterQuest
final class StoryModelTest: XCTestCase {
  //    var store = firestore()

  
  func testStoryInitialization() throws {
    let story = Story(id: "storyTest",
                      completed: false,
                      images: ["image1", "image2"],
                      pageNum: 10,
                      purchasable: true,
                      storyDescription: "test story",
                      storyName: "test name",
                      storyPreviewImage: "image1",
                      sentences: ["abc", "def"])
    XCTAssertEqual(story.id, "storyTest")
    XCTAssertEqual(story.completed, false)
    XCTAssertEqual(story.images, ["image1", "image2"])
    XCTAssertEqual(story.pageNum, 10)
    XCTAssertEqual(story.purchasable, true)
    XCTAssertEqual(story.storyDescription, "test story")
    XCTAssertEqual(story.storyName, "test name")
    XCTAssertEqual(story.storyPreviewImage, "image1")
    XCTAssertEqual(story.sentences, ["abc", "def"])
  }
}
