//
//  Quest.swift
//  Pawse
//
//  Created by hendra on 22/06/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

enum QuestType: String, Codable {
    case Sad
    case Angry
    case Anxiety
}

struct Quest: Codable, Identifiable {
    @DocumentID var id: String?
    var date: Date
    var name: String
    var icon: String
    var description: String
    var type: QuestType
    var navigation: String
    var coin: Int
    var duration: Int
    var progress: Int
    var isCompleted: Bool
    var storyId: String
    
    enum CodingKeys: String, CodingKey
    {
        case id
        case date
        case name
        case icon
        case description
        case type
        case navigation
        case coin
        case duration
        case progress
        case isCompleted = "is_completed"
        case storyId = "story_id"
    }
}

extension Quest {
  static var empty: Quest {
      Quest(date: Date(),name: "Shout", icon: "mouth",description: "Tell Your Story", type: .Angry, navigation: "Shout", coin: 3, duration: 300, progress: 0, isCompleted: false, storyId: "")
  }
    
    static func quests(for type: QuestType, storyId: String) -> [Quest] {
        let currentDate = Date()
      switch type {
      case .Sad:
          return [
            Quest(date: currentDate,name: "Share", icon: "mic",description: "tell your story", type: .Sad, navigation: "Sharing", coin: 3, duration: 300, progress: 0, isCompleted: false, storyId: storyId),
            Quest(date: currentDate,name: "Draw", icon: "pencil.line",description: "draw anything you want", type: .Sad, navigation: "Draw", coin: 3, duration: 300, progress: 0, isCompleted: false, storyId: storyId),
            Quest(date: currentDate,name: "Journal", icon: "book",description: "tell 3 things that you grateful", type: .Sad, navigation: "Journal_Sad", coin: 3, duration: 300, progress: 0, isCompleted: false, storyId: storyId)
          ]
      case .Angry:
          return [
            Quest(date: currentDate,name: "Draw", icon: "pencil.line",description: "draw anything you want", type: .Angry, navigation: "Draw", coin: 3, duration: 300, progress: 0, isCompleted: false, storyId: storyId),
            Quest(date: currentDate,name: "Shout", icon: "mouth",description: "shout as much as you can", type: .Angry, navigation: "Shout", coin: 3, duration: 300, progress: 0, isCompleted: false, storyId: storyId),
            Quest(date: currentDate,name: "Punch", icon: "figure.boxing",description: "punch as much as you want", type: .Angry, navigation: "Punch", coin: 3, duration: 300, progress: 0, isCompleted: false, storyId: storyId)
          ]
      case .Anxiety:
          return [
            Quest(date: currentDate,name: "Meditation",icon:"figure",description: "relax yourself", type: .Anxiety, navigation: "Meditation", coin: 3, duration: 300, progress: 0, isCompleted: false, storyId: storyId),
            Quest(date: currentDate,name: "Challenges", icon: "flag.checkered",description: "follow the step to relax yourself", type: .Anxiety, navigation: "Challenges", coin: 3, duration: 300, progress: 0, isCompleted: false, storyId: storyId),
            Quest(date: currentDate,name: "Journal", icon: "book",description: "answer all the questions", type: .Anxiety, navigation: "Journal_Anxiety", coin: 3, duration: 300, progress: 0, isCompleted: false, storyId: storyId)
          ]
      }
  }
}
