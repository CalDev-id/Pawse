//
//  Route.swift
//  Pawse
//
//  Created by hendra on 22/06/24.
//

import Foundation
import SwiftUI

enum PawseRoute: String, Hashable, Codable {
    case Login
    case Home
    case Journal
    case JournalResult
    
}

class Route: ObservableObject {
    @Published var pawsePath = NavigationPath()
    
    func navigate(pawseRoute: PawseRoute) {
        pawsePath.append(pawseRoute)
    }
    
    func popToRoot(){
        pawsePath.removeLast(pawsePath.count)
    }
    
    func pop()  {
        pawsePath.removeLast()
    }
}
