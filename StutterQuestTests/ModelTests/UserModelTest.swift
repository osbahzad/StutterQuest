//
//  UserModelTest.swift
//  StutterQuestTests
//
//  Created by Veronica Benedict on 11/18/24.
//

import XCTest
@testable import StutterQuest
final class UserModelTest: XCTestCase {

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
  
  func testUserInitialization() throws {
    let user = User(user_id: "userTest",
                    nickname: "test name",
                    email: "user_test@email.com",
                    password: "password",
                    num_stories_read: 2,
                    num_streak_days: 3,
                    num_hours_played: 4,
                    completed_stories: ["story1", "story2"],
                    purchased_stories: ["story3", "story4"],
                    rank:1)
    XCTAssertEqual(user.user_id, "userTest")
    XCTAssertEqual(user.nickname, "test name")
    XCTAssertEqual(user.email, "user_test@email.com")
    XCTAssertEqual(user.password, "password")
    XCTAssertEqual(user.num_stories_read, 2)
    XCTAssertEqual(user.num_streak_days, 3)
    XCTAssertEqual(user.num_hours_played, 4)
    XCTAssertEqual(user.completed_stories, ["story1", "story2"])
    XCTAssertEqual(user.purchased_stories, ["story3", "story4"])
    XCTAssertEqual(user.rank, 1)
  }
  
  func testUserEncoding() throws {
          let user = User(
              user_id: "123",
              nickname: "TestUser",
              email: "test@example.com",
              password: "password123",
              num_stories_read: 10,
              num_streak_days: 5,
              num_hours_played: 20,
              completed_stories: ["Story1", "Story2"],
              purchased_stories: ["Story3"],
              rank: 1
          )
          
          let encoder = JSONEncoder()
          let data = try encoder.encode(user)
          XCTAssertNotNil(data)
      }
  
  func testUserDecoding() throws {
    let json = """
    {
        "user_id": "123",
        "nickname": "TestUser",
        "email": "test@example.com",
        "password": "password123",
        "num_stories_read": 10,
        "num_streak_days": 5,
        "num_hours_played": 20,
        "completed_stories": ["Story1", "Story2"],
        "purchased_stories": ["Story3"],
        "rank": 1
    }
    """.data(using: .utf8)!
    let decoder = JSONDecoder()
    let user = try decoder.decode(User.self, from: json)
    XCTAssertEqual(user.user_id, "123")
    XCTAssertEqual(user.nickname, "TestUser")
    XCTAssertEqual(user.email, "test@example.com")
    XCTAssertEqual(user.password, "password123")
    XCTAssertEqual(user.num_stories_read, 10)
    XCTAssertEqual(user.num_streak_days, 5)
    XCTAssertEqual(user.num_hours_played, 20)
    XCTAssertEqual(user.completed_stories, ["Story1", "Story2"])
    XCTAssertEqual(user.purchased_stories, ["Story3"])
    XCTAssertEqual(user.rank, 1)
  }

                    
    

}
