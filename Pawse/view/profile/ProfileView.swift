//
//  ProfileView.swift
//  Pawse
//
//  Created by hendra on 24/06/24.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject private var profileViewModel = ProfileViewModel()
        
    var body: some View {
        VStack(alignment: .leading) {
            Profile(user: profileViewModel.user ?? User.empty)
                .padding(.top, 20.0)
          
        
            TodayTaskView(completedTasks: profileViewModel.completedQuests, notCompletedTasks: profileViewModel.uncompletedQuests)
                .padding(.top, 20.0)
            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden()
        .onAppear {
            profileViewModel.getLatestEmotion()
            profileViewModel.updateQuestCounts()
        }
    }
}

#Preview {
    ProfileView()
}
