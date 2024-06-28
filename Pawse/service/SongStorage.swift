//
//  SongStorage.swift
//  Pawse
//
//  Created by hendra on 27/06/24.
//

import Foundation

class SongStorage {
    private let userDefaultsKey = "songs"
    private let currentSongKey = "current_song"
    
    func saveSongs(_ songs: [Song]) {
        if let encoded = try? JSONEncoder().encode(songs) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    func loadSongs() -> [Song] {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsKey) {
            if let decoded = try? JSONDecoder().decode([Song].self, from: savedData) {
                return decoded
            }
        }
        return []
    }
    
    func saveCurrentSong(_ song: Song) {
        if let encoded = try? JSONEncoder().encode(song) {
            UserDefaults.standard.set(encoded, forKey: currentSongKey)
        }
    }
    
    func loadCurrentSong() -> Song? {
        if let savedData = UserDefaults.standard.data(forKey: currentSongKey) {
            if let decoded = try? JSONDecoder().decode(Song.self, from: savedData) {
                return decoded
            }
        }
        return nil
    }
}
