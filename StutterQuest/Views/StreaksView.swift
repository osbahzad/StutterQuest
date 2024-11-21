//
//  StreaksView.swift
//  StutterQuest
//
//  Created by Veronica Benedict on 11/20/24.
//

import SwiftUI

struct StreaksView: View {
  @StateObject private var userDataViewModel = UserDataViewModel()
    var body: some View {
      VStack{
        Text("Progress")
          .font(.title)
          .fontWeight(.bold)
        HStack {
          VStack{
            Image("days_read")
              .padding()
            Text("\(String(describing: userDataViewModel.num_days_read)) days_read")
          }
          VStack {
            Image("hours_read")
              .padding()
            Text("\(String(describing: userDataViewModel.num_hours_read)) hours read")
          }
          VStack {
            Image("books_read")
              .padding()
            Text("\(String(describing: userDataViewModel.num_books_read)) books read")
          }
          NavigationBarView()
            
        }
        
      }
      .navigationBarBackButtonHidden(true)
      .background(
        Image("login_background")
          .edgesIgnoringSafeArea(.all)
      )
    }
   
}

#Preview {
    StreaksView()
}
