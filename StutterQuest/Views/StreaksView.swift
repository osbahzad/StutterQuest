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
      VStack(spacing: -30) {

        Text("Progress")
            .font(.system(size: 40, weight: .bold))

        HStack(spacing: 20) {
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
              .frame(width: 80)
          
        }
        .padding(.horizontal)
        
      }.padding(.top, 30)
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

#Preview {
  StreaksView(email: "test@gmail.com", nickname: "John")
}
