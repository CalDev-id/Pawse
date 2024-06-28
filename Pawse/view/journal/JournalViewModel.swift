//
//  JournalViewModel.swift
//  Pawse
//
//  Created by hendra on 24/06/24.
//

import Foundation

class JournalViewModel: ObservableObject {
    private var storyService = StoryService()
    private var questService = QuestService()
    
    public func saveStory(story: Story, completion: @escaping (Result<Void, Error>) -> Void) {
        storyService.saveStory(story: story) { result in
            switch result {
            case .success(let savedStory):
                do {
                    let questType = QuestType(rawValue: savedStory.emotion)
                    try self.questService.createAutoQuests(type: questType!, storyId: savedStory.id!)
                    completion(.success(()))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
