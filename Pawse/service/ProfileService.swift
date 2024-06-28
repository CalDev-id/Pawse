//
//  ProfileService.swift
//  Pawse
//
//  Created by hendra on 22/06/24.
//

import Foundation
import FirebaseFirestore


class ProfileService {
    private var db = Firestore.firestore()
    private var tableName = "users"
    
    func saveProfile(profile: User, userId: String) throws {
        try db.collection(tableName).document(userId).setData(from: profile)
    }
    
    func getProfile(completion: @escaping (Result<User, Error>) -> Void) {
        db.collection(tableName).limit(to: 1).getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching profile: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }

            guard let documents = snapshot?.documents, let document = documents.first else {
                let noDocumentsError = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No profile found"])
                completion(.failure(noDocumentsError))
                return
            }

            do {
                let user = try document.data(as: User.self)
                completion(.success(user))
            } catch {
                print("Error decoding profile: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    func updateProfile(user: User, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try db.collection(tableName).document(user.uid).setData(from: user, merge: true) { error in
                if let error = error {
                    print("Error updating profile: \(error.localizedDescription)")
                    completion(.failure(error))
                } else {
                    print("Profile successfully updated!")
                    completion(.success(()))
                }
            }
        } catch {
            print("Error serializing profile: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }
}
