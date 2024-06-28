//
//  CardView.swift
//  Loty
//
//  Created by Akmal Hakim on 23/06/24.
//

import SwiftUI

struct CardView: View {
    let quest: Quest
    
    var body: some View {
        let progressPercentage: Float = (Float(quest.progress) / Float(quest.duration)) * 100
        HStack(alignment: .center, spacing: 24) {
            Image(systemName: quest.icon)
                .frame(width: 48, height: 48)
            VStack(alignment: .leading, spacing: 6) {
                HStack(alignment: .center) {
                    // Space Between
                    VStack(alignment: .leading, spacing: 0) {
                        Text(quest.name)
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 0.24, green: 0.26, blue: 0.31))
                        Text(quest.description)
                            .font(.subheadline)
                          .foregroundColor(Color(red: 0.5, green: 0.5, blue: 0.5))
                    }
                    .padding(0)
                    Spacer()
                    // Alternative Views and Spacers
                    VStack(alignment: .center, spacing: 0) {
                        Image(systemName: "dollarsign.circle.fill")
                            .foregroundColor(Color(red: 0.92, green: 0.76, blue: 0.32))
                        Text(quest.coin.description)
                            .font(.footnote)
                            .foregroundColor(Color(red: 0.79, green: 0.51, blue: 0))
                    }
                    .padding(0)
                }
                .padding(0)
                .frame(maxWidth: .infinity, alignment: .center)
                VStack(alignment: .leading, spacing: 2) {
                    Text(quest.isCompleted ? "Progress: completed" : "Progress: uncompleted")
                      .font(Font.custom("SF Pro", size: 12))
                      .foregroundColor(Color(red: 0.68, green: 0.39, blue: 0))
                    ProgressView(value: progressPercentage)
                        .progressViewStyle(LinearProgressViewStyle(tint: .orange))
                        .frame(height: 4)
                        .cornerRadius(2)
                        .padding(.top, 4)
                }
                .padding(0)
            }
            .padding(0)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 0.96, green: 0.95, blue: 0.93))
        .cornerRadius(25)
    }
}

struct DisabledCardView: View {
    var body: some View {
        HStack(alignment: .center, spacing: 24) {
            Image(systemName: "lock.fill")
                .font(.system(size: 36))
                .overlay {
                    Rectangle()
                        .fill(.black)
                        .opacity(0.3)
                }
            Text("Please start journaling first!")
                .font(.system(size: 17))
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
              .foregroundColor(Color(red: 0.24, green: 0.26, blue: 0.31))
              .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
        .frame(width: 396, alignment: .leading)
        .background(Color(red: 0.96, green: 0.95, blue: 0.93))
        .cornerRadius(25)
        .opacity(0.7)
    }
}


#Preview {
    CardView(quest: Quest.empty)
}
