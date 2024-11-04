//
//  StorySelectionViewModel.swift
//  StutterQuest
//
//  Created by Wenchao Hu on 11/1/24.
//


import Foundation
import Combine

class StorySelectionViewModel: ObservableObject {
  @Published var storyViewModels: [StoryViewModel] = []
  private var cancellables: Set<AnyCancellable> = []

  @Published var storyRepository = StoryRepository()
  
  init() {
      storyRepository.$stories.map { stories in
          print("Stories loaded: \(stories.count)")
          for story in stories {
              print("Story Name: \(story.storyName), Description: \(story.storyDescription)")
          }
          return stories.map(StoryViewModel.init)
      }
      .assign(to: \.storyViewModels, on: self)
      .store(in: &cancellables)
  }
}
