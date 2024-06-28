//
//  UserQuest.swift
//  Pawse
//
//  Created by hendra on 24/06/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct UserQuest: Codable, Identifiable {
    @DocumentID var id: String?
    var questId: String
    var userId: String
    var storyId: String
    var progress: Int
    var isCompleted: Bool
    enum CodingKeys: String, CodingKey {
        case id
        case questId = "quest_id"
        case userId = "user_id"
        case storyId = "story_id"
        case progress
        case isCompleted = "is_completed"
    }
}
