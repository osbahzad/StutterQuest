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
  
//  func testStoryDecoding() throws {
//          let json = """
//          {
//              "documentID": "123",
//              "completed": true,
//              "image": ["image1", "image2"],
//              "page_num": 10,
//              "purchasable": true,
//              "story_description": "A great story",
//              "story_name": "The Best Story",
//              "story_preview_image": "previewImage",
//              "text": ["Sentence one", "Sentence two"]
//          }
//          """.data(using: .utf8)!
//          
//          let decoder = JSONDecoder()
//          let story = try decoder.decode(Story.self, from: json)
//          
//          XCTAssertEqual(story.id, "123")
//          XCTAssertEqual(story.completed, true)
//          XCTAssertEqual(story.images, ["image1", "image2"])
//          XCTAssertEqual(story.pageNum, 10)
//          XCTAssertEqual(story.purchasable, true)
//          XCTAssertEqual(story.storyDescription, "A great story")
//          XCTAssertEqual(story.storyName, "The Best Story")
//          XCTAssertEqual(story.storyPreviewImage, "previewImage")
//          XCTAssertEqual(story.sentences, ["Sentence one", "Sentence two"])
//      }
  }
