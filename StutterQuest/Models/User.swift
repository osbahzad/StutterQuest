import Foundation
import Firebase

class User: Identifiable, Codable, ObservableObject {
    var user_id: String
    var nickname: String
    var email: String
    var password: String
    var num_stories_read: Int
    var num_streak_days: Int
    var num_hours_played: Int
    var completed_stories: [String]
    var purchased_stories: [String]
    var rank: Int
    
    enum CodingKeys: String, CodingKey {
        case user_id
        case nickname
        case email
        case password
        case num_stories_read
        case num_streak_days
        case num_hours_played
        case completed_stories
        case purchased_stories
        case rank
    }
    
  init(user_id: String, nickname: String, email: String, password: String, num_stories_read: Int, num_streak_days: Int, num_hours_played: Int, completed_stories: [String], purchased_stories: [String], rank: Int) {
        self.user_id = user_id
        self.nickname = nickname
        self.email = email
        self.password = password
        self.num_stories_read = num_stories_read
        self.num_streak_days = num_streak_days
        self.num_hours_played = num_hours_played
        self.completed_stories = completed_stories
        self.purchased_stories = purchased_stories
        self.rank = rank
    }
}
