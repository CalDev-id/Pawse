//
//  StoryService.swift
//  Pawse
//
//  Created by hendra on 22/06/24.
//

import Foundation
import FirebaseFirestore

class StoryService {
    private var db = Firestore.firestore()
    private var tableName = "story"
    
    func saveStory(story: Story, completion: @escaping (Result<Story, Error>) -> Void) {
        var storyWithID = story
        let documentRef = db.collection(tableName).document()
        storyWithID.id = documentRef.documentID
        
        do {
            try documentRef.setData(from: storyWithID) { error in
                if let error = error {
                    print("Error saving story: \(error.localizedDescription)")
                    completion(.failure(error))
                } else {
                    print("Story successfully saved!")
                    completion(.success(storyWithID))
                }
            }
        } catch {
            print("Error serializing story: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }
    
    func getLatestTodayStory(completion: @escaping (Story?, Error?) -> Void) {
        let currentDate = Date()
        let startOfDay = Calendar.current.startOfDay(for: currentDate)
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
        db.collection(tableName)
            .whereField("date", isGreaterThanOrEqualTo: startOfDay)
            .whereField("date", isLessThan: endOfDay)
            .order(by: "date", descending: true)
            .limit(to: 1)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    completion(nil, error)
                } else {
                    guard let documents = querySnapshot?.documents else {
                        completion(nil, nil)
                        return
                    }
                    do {
                        let story = try documents.compactMap {
                            try $0.data(as: Story.self)
                        }.first
                        completion(story, nil)
                    } catch {
                        completion(nil, error)
                    }
                }
            }
    }
}
