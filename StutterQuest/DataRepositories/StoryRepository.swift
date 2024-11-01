//
//  StoryRepository.swift
//  StutterQuest
//
//  Created by Wenchao Hu on 11/1/24.
//

import Foundation 
import Combine
import FirebaseFirestore


class StoryRepository: ObservableObject {
  private let path: String = "story"
  private let store = Firestore.firestore()

  @Published var stories: [Story] = []
  private var cancellables: Set<AnyCancellable> = []

  init() {
    self.get()
  }

  func get() {
    store.collection(path)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error getting stories: \(error.localizedDescription)")
                    return
                }

                // Debug purposes
//                if let documents = querySnapshot?.documents {
//                    print("Documents fetched: \(documents.count)")
//                    for document in documents {
//                        print("Document ID: \(document.documentID), Data: \(document.data())")
//                    }
//                }

                self.stories = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: Story.self)
                } ?? []
            }
    
  }
 
}

