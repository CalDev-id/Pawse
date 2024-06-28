//
//  CatView.swift
//  Loty
//
//  Created by Akmal Hakim on 23/06/24.
//

import SwiftUI

struct CatView: View {
    let user: User
    let story: Story
    
    private func getLottieAnimationName(for emotion: String) -> String {
        print("Emosi\(emotion)")
        switch emotion {
        case "Sad":
            return "sedih homepage"
        case "Angry":
            return "marah homepage"
        case "Anxiety":
            return "cemas homepage"
        default:
            return "sedih homepage"
        }
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .center, spacing: 36) {
                HStack(alignment: .center) {
                    Image(systemName: "dollarsign.circle.fill")
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.92, green: 0.76, blue: 0.32))
                    // Space Between
                    HStack(alignment: .center, spacing: 0) {
                        Text(user.coin.description)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.92, green: 0.76, blue: 0.32))
                    }
                    .padding(0)
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
                .frame(width: .infinity, alignment: .center)
                .background(Color(red: 0.64, green: 0.52, blue: 0.37))
                LottieView(name: getLottieAnimationName(for: story.emotion), loopMode: .loop)
                NavigationLink(destination: JournalView()) {
                    Label("Start Journaling", systemImage: "book.closed.fill")
                          .padding(.horizontal, 0)
                          .padding(.vertical, 16)
                          .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .top)
                          .background(Color(red: 0.19, green: 0.69, blue: 0.78))
                          .foregroundColor(.white)
                }
            }
            .background(Color(red: 0.92, green: 0.87, blue: 0.81))
            .cornerRadius(40)
            
        }
    }
}

#Preview {
    CatView(user: User.empty, story: Story.empty)
}
