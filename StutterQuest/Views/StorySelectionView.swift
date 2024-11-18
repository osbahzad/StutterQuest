//
//  StorySelectionView.swift
//  StutterQuest
//
//  Created by Omar Bahzad on 10/31/24.


import SwiftUI

struct StorySelectionView: View {
  
  @ObservedObject var storyRepository = StoryRepository()
  var nickname: String

  var body: some View {
    NavigationView {
      
      HStack() {
        VStack(alignment: .leading) {
          Text("Hi \(nickname.capitalized)!")
            .font(.system(size: 40, weight: .bold))
            .padding(.leading)
          
          // Horizontal scroll for stories
          ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 25) {
              
              ForEach(storyRepository.stories) { story in
                NavigationLink(
                  destination: StoryView(story: story)
                ) {
                  StoryCardView(story: story)
                }
                .buttonStyle(PlainButtonStyle())
              }
            }
          }  
        }
        .padding()
        
        NavigationBarView()
          .frame(width: 70)
      }
      
      .padding(.top, 20)
      
      .background(
        Image("login_background")
          .edgesIgnoringSafeArea(.all)
      )
    }
    .navigationBarBackButtonHidden(true)
  }
}
 
struct StorySelectionView_Previews: PreviewProvider {
  static var previews: some View {
    StorySelectionView(nickname: "John")
  }
}
