//
//  StoryViewModel.swift
//  StutterQuest
//
//  Created by Wenchao Hu on 11/1/24.
//

import Foundation
import Combine

class StoryViewModel: ObservableObject, Identifiable {

  private let storyRepository = StoryRepository()
  @Published var story: Story
  private var cancellables: Set<AnyCancellable> = []
  var id = ""

  init(story: Story) {
    self.story = story
    $story
      .compactMap { $0.id }
      .assign(to: \.id, on: self)
      .store(in: &cancellables)
  }
  
}
