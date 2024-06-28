//
//  TodayTask.swift
//  Task Manager
//
//  Created by Kevin Fairuz on 24/06/24.
//

import SwiftUI

struct Profile: View {
    let user: User
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack() {
                    Circle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 100, height: 100)
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.title)
                        Text(user.email)
                            .font(.callout)
                            .foregroundColor(.gray)
                        Text("\(user.coin) points")
                            .font(.title3)
                            .foregroundColor(.yellow)
                            .bold()
                    }
                    .padding(.leading, 10)
                    
                }
                .padding()
                
            }
            
        }.padding(.horizontal, 24)
            .padding(.vertical, 16)
            .frame(width: 356, height: 138, alignment: .leading)
            .background(Color(red: 0.99, green: 0.96, blue: 0.92))
            .opacity(0.5)
            .cornerRadius(25)
            .overlay(
              RoundedRectangle(cornerRadius: 25)
                .inset(by: 0.5)
                .stroke(Color(red: 1, green: 0.85, blue: 0.64), lineWidth: 1)
        )
    }
}
