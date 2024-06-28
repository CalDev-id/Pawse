//
//  Story.swift
//  Pawse
//
//  Created by hendra on 22/06/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Story: Codable, Identifiable {
    @DocumentID var id: String?
    var date: Date = Date()
    var confidenceLevel: Int
    var emotion: String
    var story: String
    
    enum CodingKeys: String, CodingKey
    {
        case id
        case date
        case confidenceLevel = "confidence_level"
        case emotion
        case story
    }
}

extension Story {
  static var empty: Story {
      Story(confidenceLevel: 0, emotion: "", story: "")
  }
}
