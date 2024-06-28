//
//  CongratsViewModel.swift
//  Pawse
//
//  Created by hendra on 27/06/24.
//

import Foundation

class CongratsViewModel: ObservableObject {
    var user: User?
    @Published public var navigateToMoodView = false
    private var profileService = ProfileService()
    private var questService = QuestService()
    
    init() {
        self.fetchProfile()
    }
    
    private func fetchProfile() {
        profileService.getProfile { result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.user = user
                }
            case .failure(let error):
                print("Fetch Profile Error \(error)")
            }
        }
    }
    
    public func completeQuest(quest: Quest) {
            var updatedQuest = quest
            updatedQuest.isCompleted = true
            updatedQuest.progress = 100
            questService.updateQuest(quest: updatedQuest) { result in
                switch result {
                case .success:
                    if var user = self.user {
                        user.coin += quest.coin
                        self.profileService.updateProfile(user: user) { profileResult in
                            switch profileResult {
                            case .success:
                                DispatchQueue.main.async {
                                    self.user = user
                                    self.navigateToMoodView = true
                                }
                                print("Profile successfully updated!")
                            case .failure(let error):
                                print("Error updating profile: \(error)")
                            }
                        }
                    }
                case .failure(let error):
                    print("Error updating quest: \(error)")
                }
            }
        }
}
