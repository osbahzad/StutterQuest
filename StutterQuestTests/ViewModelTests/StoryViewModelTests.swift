//
//  StoryViewModelTests.swift
//  StutterQuestTests
//
//  Created by Veronica Benedict on 12/5/24.
//

import Foundation
import XCTest
import Combine
@testable import StutterQuest

class StoryViewModelTests: XCTest {
  
  var viewModel: StoryViewModel!
  var story: Story!
  var cancellables: Set<AnyCancellable> = []
  
  override func setUp() {
    super.setUp()
    cancellables = []
    
    story = Story(
      id: "12",
      completed: false,
      images: ["image1", "image2"],
      pageNum: 4,
      purchasable: false,
      storyDescription: "A story about a cat",
      storyName: "Cat Story",
      storyPreviewImage: "previewImage",
      sentences: ["Sentence one", "Sentence two", "Sentence three", "Sentence four"]
    )
    
    viewModel = StoryViewModel(story: story)
  }
  
  override func tearDown() {
    viewModel = nil
    story = nil
    cancellables = []
    super.tearDown()
  }
  
  func testInitialization() throws {
    XCTAssertEqual(viewModel.story.id, "123")
    XCTAssertEqual(viewModel.story.completed, true)
    XCTAssertEqual(viewModel.story.images, ["image1", "image2"])
    XCTAssertEqual(viewModel.story.pageNum, 10)
    XCTAssertEqual(viewModel.story.purchasable, true)
    XCTAssertEqual(viewModel.story.storyDescription, "A great story")
    XCTAssertEqual(viewModel.story.storyName, "The Best Story")
    XCTAssertEqual(viewModel.story.storyPreviewImage, "previewImage")
    XCTAssertEqual(viewModel.story.sentences, ["Sentence one", "Sentence two"])
  }
  
  func testIdAssignment() throws {
    XCTAssertEqual(viewModel.id, "123")
  }
  
  func testStoryUpdate() throws{
      let newStory = Story(
          id: "456",
          completed: false,
          images: ["image3", "image4"],
          pageNum: 20,
          purchasable: false,
          storyDescription: "Another great story",
          storyName: "The Second Best Story",
          storyPreviewImage: "previewImage2",
          sentences: ["Sentence three", "Sentence four"]
      )

      viewModel.story = newStory

      XCTAssertEqual(viewModel.id, "456")
      XCTAssertEqual(viewModel.story.id, "456")
      XCTAssertEqual(viewModel.story.completed, false)
      XCTAssertEqual(viewModel.story.images, ["image3", "image4"])
      XCTAssertEqual(viewModel.story.pageNum, 20)
      XCTAssertEqual(viewModel.story.purchasable, false)
      XCTAssertEqual(viewModel.story.storyDescription, "Another great story")
      XCTAssertEqual(viewModel.story.storyName, "The Second Best Story")
      XCTAssertEqual(viewModel.story.storyPreviewImage, "previewImage2")
      XCTAssertEqual(viewModel.story.sentences, ["Sentence three", "Sentence four"])
  }
}
