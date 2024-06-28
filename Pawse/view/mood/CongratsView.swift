//
//  CongratsView.swift
//  Pawse
//
//  Created by hendra on 27/06/24.
//

import SwiftUI
import DotLottie

struct CongratsView: View {
    
    var quest: Quest
    
    @ObservedObject private var congratsViewModel = CongratsViewModel()
    
    var body: some View {
        VStack{
            VStack{
                LottieView(name: "congratulations", loopMode: .loop)
                    .frame(width: 400, height: 400)
                Text("Congratulations!")
                    .bold()
                    .multilineTextAlignment(.center)
                    .font(.title)
                Text("You have successfully release your negative feelings.")
                    .multilineTextAlignment(.center)
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
                    .font(.system(size: 13))
                Text("You have earned \(quest.coin) Points")
                    .multilineTextAlignment(.center)
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
                    .font(.system(size: 20))
                    .padding()
            }
            .padding(.top, 60)
            Spacer()
            VStack {

                Button {
                    saveQuestAndNavigate()
                } label: {
                    Text("Continue")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.biruTuaSlider)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $congratsViewModel.navigateToMoodView, destination: {
                    ContentView()
                })
    }
    
    private func saveQuestAndNavigate() {
        congratsViewModel.completeQuest(quest: quest)
    }
}

#Preview {
    CongratsView(quest: Quest.empty)
}
