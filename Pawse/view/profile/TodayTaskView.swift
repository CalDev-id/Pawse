//
//  TodayTaskView.swift
//  Task Manager
//
//  Created by Kevin Fairuz on 24/06/24.
//

import SwiftUI

struct TodayTaskView: View {
    let completedTasks: Int
    let notCompletedTasks: Int
    
    var body: some View {
        ZStack {
            HStack(alignment: .center, spacing: 10) {
                VStack {
                    Text("Today's Task")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom, 8)
                    
                    CircularProgressView(completedTasks: completedTasks, notCompletedTasks: notCompletedTasks)
                }
                
                VStack(alignment: .center) {
                    Text("\(completedTasks)")
                        .font(.title)
                    Text("completed")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("\(notCompletedTasks)")
                        .font(.title)
                    Text("not completed")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
            }.padding(.bottom, 36)
            
        }
        .padding(.horizontal, 24)
            .padding(.vertical, 16)
            .frame(width: 356, height: 300, alignment: .leading)
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

struct CircularProgressView: View {
    var completedTasks: Int
    var notCompletedTasks: Int
    
    var body: some View {
        let totalTasks = completedTasks + notCompletedTasks
        let progress = totalTasks > 0 ? Double(completedTasks) / Double(totalTasks) : 0.0
        
        ZStack {
            VStack(alignment: .leading) {
                Circle()
                    .stroke(lineWidth: 15)
                    .opacity(0.3)
                    .foregroundColor(.gray)
            }
            Circle()
                .trim(from: 0.0, to: CGFloat(progress))
                .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                .foregroundColor(.orange)
                .rotationEffect(Angle(degrees: 270))
        }

        .padding(.horizontal, 60)
        .padding(.top)
    }
}

#Preview {
    TodayTaskView(completedTasks: 2, notCompletedTasks: 2)
}
