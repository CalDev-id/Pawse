//
//  SongViewModel.swift
//  Pawse
//
//  Created by Akmal Hakim on 26/06/24.
//

import Foundation
import SwiftUI
import AVFoundation

class SongViewModel: ObservableObject {
    @Published var user: User?
    @Published var songs: [Song]
    private var audioPlayer: AVAudioPlayer?
    @Published var currentlyPlayingSong: Song?
    @Published var isPlaying = false
    private let songStorage = SongStorage()
    private var profileService = ProfileService()
    @Published var errorMessage: String? = nil
    
    init() {
        self.songs = songStorage.loadSongs()
        if songs.isEmpty {
            self.songs = [
                Song(name: "Weightless", description: "if you need to calm down your anxiety", coin: 5, isBought: false, fileName: "Weightless.mp3"),
                Song(name: "Serene Solitude", description: "Evoke a sense of tranquility", coin: 3, isBought: true, fileName: "Gymnopede.mp3"),
                Song(name: "Whispers in the Glass", description: "a sense of dialogue and reflection", coin: 4, isBought: false, fileName: "Spiegel.mp3")
            ]
            songStorage.saveSongs(songs)
        }
        self.fetchProfile()
    }
    
    private func fetchProfile() {
        profileService.getProfile { result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.user = user
                }
            case .failure(let error):
                print("Fetch Profile Error \(error)")
            }
        }
    }
    
    func buySong(_ song: Song) {
        guard let user = user else { return }
        if user.coin >= song.coin {
            if let index = songs.firstIndex(where: { $0.id == song.id }) {
                songs[index].isBought = true
                songStorage.saveSongs(songs)
                
                var updatedUser = user
                updatedUser.coin -= song.coin
                profileService.updateProfile(user: updatedUser) { result in
                    switch result {
                    case .success:
                        DispatchQueue.main.async {
                            self.user = updatedUser
                        }
                    case .failure(let error):
                        print("Error updating user profile: \(error)")
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.errorMessage = "Not enough coins to buy the song."
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.errorMessage = nil
                }
            }
        }
    }
    
    func playPreview(song: Song) {
        guard let url = Bundle.main.url(forResource: song.fileName, withExtension: nil) else { return }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
                self.audioPlayer?.stop()
                self.audioPlayer = nil
            }
        } catch {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }
    
    func playSong(_ song: Song) {
        guard let url = Bundle.main.url(forResource: song.fileName, withExtension: nil) else { return }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            currentlyPlayingSong = song
            isPlaying = true
            songStorage.saveCurrentSong(song)
        } catch {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }
    
    func stopSong() {
        audioPlayer?.stop()
        audioPlayer = nil
        currentlyPlayingSong = nil
        isPlaying = false
    }
}
