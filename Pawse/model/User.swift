//
//  Profile.swift
//  Pawse
//
//  Created by hendra on 22/06/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct User: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var coin: Int
    var uid: String
    var email: String
    
    enum CodingKeys: String, CodingKey
    {
        case id
        case name
        case coin
        case uid
        case email
    }
}

extension User {
  static var empty: User {
      User(name: "", coin: 0, uid: "", email: "")
  }
}
