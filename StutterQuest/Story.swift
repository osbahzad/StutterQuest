//
//  Story.swift
//  StutterQuest
//
//  Created by Wenchao Hu on 11/1/24.
//

import Foundation 
import FirebaseFirestore

struct Story: Identifiable, Decodable {
  
  // MARK: Fields
  @DocumentID var id: String?
  var completed: Bool
  var images: [String]
  var pageNum: Int
  var purchasable: Bool
  
  var storyDescription: String
  var storyName: String
  
  var storyPreviewImage: String
  var sentences: [String]
  
  // MARK: Codable
  enum CodingKeys: String, CodingKey {
    case id = "documentID"
    case completed
    case images = "image"
    case pageNum = "page_num"
    case purchasable
    
    case storyDescription = "story_description"
    case storyName = "story_name"
    
    case storyPreviewImage = "story_preview_image"
    case sentences = "text"
  }
}


