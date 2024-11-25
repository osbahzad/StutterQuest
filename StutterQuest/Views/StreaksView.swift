//
//  StreaksView.swift
//  StutterQuest
//
//  Created by Veronica Benedict on 11/20/24.
//

import SwiftUI

struct StreaksView: View {
  @StateObject private var userDataViewModel = UserDataViewModel()
  @State private var num_days = 0
  @State private var num_hours = 0
  @State private var num_books = 0
  var email: String
  var nickname: String
    var body: some View {
      VStack{
        Text("Progress")
          .font(.title)
          .fontWeight(.bold)
        HStack {
          VStack{
            Image("days_read")
              .padding()
            Text("\(num_days) day streak!")
          }
          VStack {
            Image("hours_read")
              .padding()
            Text("\(num_hours) hours read")
          }
          VStack {
            Image("books_read")
              .padding()
            Text("\(num_books) books read")
          }
          NavigationBarView(email: email, nickname: nickname)
            
            
        }
        
      }
      .onAppear {
        Task {
            num_days = await userDataViewModel.fetch_num_days_read(email: email)
            num_hours = await userDataViewModel.fetch_num_hours_read(email: email)
            num_books = await userDataViewModel.fetch_num_books_read(email: email)
        }
      }
      .navigationBarBackButtonHidden(true)
      .background(
        Image("login_background")
          .edgesIgnoringSafeArea(.all)
      )
    }
   
}

//#Preview {
//    StreaksView()
//}
