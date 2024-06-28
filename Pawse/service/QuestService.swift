//
//  QuestService.swift
//  Pawse
//
//  Created by hendra on 24/06/24.
//

import Foundation
import FirebaseFirestore

class QuestService {
    private var db = Firestore.firestore()
    private var tableName = "quest"
    
    func saveQuest(quest: Quest) throws {
        try db.collection(tableName).document().setData(from: quest)
    }
    
    func updateQuest(quest: Quest, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try db.collection(tableName).document(quest.id!).setData(from: quest, merge: true) { error in
                if let error = error {
                    print("Error saving quest: \(error.localizedDescription)")
                    completion(.failure(error))
                } else {
                    print("Quest successfully saved!")
                    completion(.success(()))
                }
            }
        } catch {
            print("Error serializing story: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }
    
    func createAutoQuests(type: QuestType, storyId: String) throws {
        let quests = Quest.quests(for: type, storyId: storyId)
        for quest in quests {
            try saveQuest(quest: quest)
        }
    }

    func getCurrentQuests(for date: Date = Date(), storyId: String, completion: @escaping ([Quest]?, Error?) -> Void) {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        db.collection(tableName)
            .whereField("story_id", isEqualTo: storyId)
            .whereField("date", isGreaterThanOrEqualTo: startOfDay)
            .whereField("date", isLessThan: endOfDay)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error fetching documents: \(error)")
                    completion(nil, error)
                } else {
                    if let documents = querySnapshot?.documents {
                        print("Number of documents fetched: \(documents.count)")
                    } else {
                        print("No documents found")
                    }
                    
                    let quests = querySnapshot?.documents.compactMap { document in
                        do {
                            let quest = try document.data(as: Quest.self)
                            print("Fetched quest: \(quest)")
                            return quest
                        } catch let decodeError {
                            print("Error decoding document \(document.documentID): \(decodeError)")
                            return nil
                        }
                    }
                    completion(quests, nil)
                }
            }
    }
}
