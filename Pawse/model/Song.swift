//
//  Song.swift
//  Pawse
//
//  Created by Akmal Hakim on 26/06/24.
//

import Foundation
import SwiftUI

struct Song: Identifiable, Codable {
    let id: UUID
    let name: String
    let description: String
    let coin: Int
    var isBought: Bool
    let fileName: String
    
    init(id: UUID = UUID(), name: String, description: String, coin: Int, isBought: Bool, fileName: String) {
        self.id = id
        self.name = name
        self.description = description
        self.coin = coin
        self.isBought = isBought
        self.fileName = fileName
    }
}
