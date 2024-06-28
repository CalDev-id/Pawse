//
//  HomeView.swift
//  Loty
//
//  Created by Akmal Hakim on 23/06/24.
//

import SwiftUI

struct MoodView: View {
    @ObservedObject private var moodViewModel = MoodViewModel()
    
    var body: some View {
        VStack {
            if moodViewModel.user != nil && moodViewModel.currentStory != nil {
                HStack {
                    Spacer()
                    Image("PAWSE")
                    Spacer()
                }
                .padding()
                CatView(user: moodViewModel.user ?? User.empty, story: moodViewModel.currentStory ?? Story.empty)
                QuestView(quests: moodViewModel.quests ?? [])
            } else {
                LoadingView()
            }
        }
        .onAppear {
            moodViewModel.getLatestEmotion()
        }
        .onDisappear {
            moodViewModel.stopSound()
        }
        .navigationBarBackButtonHidden(true)
        .padding(.horizontal, 16)
    }
}

#Preview {
    MoodView()
}

//import SwiftUI
//import Speech
//
//struct MoodView: View {
//    @ObservedObject private var moodViewModel = MoodViewModel()
//
//    var body: some View {
//
//        VStack {
//            Text("Home")
//            NavigationLink(destination: JournalView()) {
//                Text(moodViewModel.currentStory?.emotion ?? "nice")
//            }
//
//            if let quests = moodViewModel.quests {
//                List(quests) { quest in
//                    NavigationLink(destination: destinationView(for: quest)) {
//                        Text(quest.name)
//                    }
//                }
//            } else {
//                Text("Loading quests...")
//            }
//        }
//        .onAppear {
//            moodViewModel.getLatestEmotion()
//        }
//
////            Navigation from Home
////            .navigationDestination(for: PawseRoute.self) { route in
////                switch route {
////                case
////                }
////            }
//    }
//
//    func requestSpeechAuthorization() {
//        SFSpeechRecognizer.requestAuthorization { authStatus in
//            switch authStatus {
//            case .authorized:
//                print("Speech recognition authorized")
//            case .denied:
//                print("Speech recognition denied")
//            case .restricted:
//                print("Speech recognition restricted")
//            case .notDetermined:
//                print("Speech recognition not determined")
//            @unknown default:
//                print("Unknown status")
//            }
//        }
//    }
//    @ViewBuilder
//    private func destinationView(for quest: Quest) -> some View {
//        switch quest.navigation {
//        case "Draw":
//            DrawLottieView(quest: quest)
//        case "Shout":
//            ShoutView()
//        case "Punch":
//            PunchView()
//        default:
//            Text("Unknown destination")
//        }
//    }
//}
//
//#Preview {
//    MoodView()
//}
