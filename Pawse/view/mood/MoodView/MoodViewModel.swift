//
//  MoodViewModel.swift
//  Pawse
//
//  Created by hendra on 24/06/24.
//

import Foundation
import AVFoundation


class MoodViewModel: ObservableObject {
    @Published var currentStory: Story?
    @Published var quests: [Quest]?
    @Published var user: User?
    @Published var currentlyPlayingSong: Song?
    
    private let songStorage = SongStorage()
    private var storyService = StoryService()
    private var questService = QuestService()
    private var profileService = ProfileService()
    private var audioPlayer: AVAudioPlayer?
    
    init() {
        fetchProfile()
        self.currentlyPlayingSong = songStorage.loadCurrentSong()
        if let song = currentlyPlayingSong {
            playSound(name: extractFileName(song.fileName))
        } else {
            playSound(name: "Nintendogs Cats Music", extensionFile: "mp3")
        }
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
    
    public func getLatestEmotion() {
        storyService.getLatestTodayStory { story, error in
            if let error = error {
                print("Error fetching the latest story: \(error.localizedDescription)")
            } else if let story = story {
                self.currentStory = story
                self.questService.getCurrentQuests(storyId: story.id!) { quests, error in
                    if let error = error {
                        print("Error fetching the latest quests: \(error.localizedDescription)")
                    } else if let quests = quests {
                        self.quests = quests
                        print(quests)
                    } else {
                        print("No quests found for today.")
                    }
                }
            } else {
                print("No stories found for today.")
            }
        }
    }
    
    func playSound(name: String, extensionFile: String = "mp3") {
        guard let url = Bundle.main.url(forResource: name, withExtension: extensionFile) else {
            print("Error: Could not find sound file \(name).")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("Error: Could not play sound file \(name). Error: \(error.localizedDescription)")
        }
    }
    
    func stopSound() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
    
    private func extractFileName(_ fullFileName: String) -> String {
        let components = fullFileName.components(separatedBy: ".")
        return components.first ?? fullFileName
    }
}
