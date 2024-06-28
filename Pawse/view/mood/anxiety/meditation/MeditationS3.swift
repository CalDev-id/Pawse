//
//  MeditationS3.swift
//  SpeechAI
//
//  Created by Heical Chandra on 25/06/24.
//

import SwiftUI
import DotLottie

struct MeditationS3: View {
    let quest: Quest
    @State private var progress: Double = 0
    @State private var timer: Timer? = nil
    var body: some View {
        VStack {
            VStack{
                VStack{
                    Text("MEDITATION")
                        .bold()
                        .multilineTextAlignment(.center)
                        .font(.title)
                    Text("follow the steps to calm yourself")
                        .multilineTextAlignment(.center)
                        .fontWeight(.thin)
                        .font(.caption)
                    Text("STEP 3")
                        .bold()
                        .multilineTextAlignment(.center)
                        .font(.title3)
                        .padding()
                    DotLottieAnimation(
                        fileName: "meditasi",
                        config: AnimationConfig(autoplay: true, loop: true)
                    )
                    .view()
                    .frame(width: 300, height: 300)
                    Text(getBreathText(for: progress))
                                    .multilineTextAlignment(.center)
                                    .padding()
                }
                .padding(.top, 70)
    //            Text(String(Int(progress)))

                Spacer()

                    if progress < 20 {
                        CustomProgressView(progress: progress)
                            .frame(width: .infinity, height: 20)
                            .padding()
                            .padding(.horizontal, 24)
                            .padding(.bottom, 50)
                    }
                    if progress == 20 {
                        VStack{
                            NavigationLink(destination: CongratsView(quest: quest)){
                                Text("Done")
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(Color.biruBTN)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                                }
                            HStack{
                                Rectangle()
                                    .fill(Color.abu)
                                    .frame(width: 35,height: 5)
                                    .cornerRadius(25)
                                Rectangle()
                                    .fill(Color.abu)
                                    .frame(width: 35,height: 5)
                                    .cornerRadius(25)
                                Rectangle()
                                    .fill(Color.biruTuaSlider)
                                    .frame(width: 35,height: 5)
                                    .cornerRadius(25)
                            }
                            .padding(5)
                        }
                        .padding()
                    }
            }
            .onAppear {
                startTimer()
                playSound(name: "breathing", extensionFile: "mp3")
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    func startTimer() {
        progress = 0
        timer?.invalidate() // Invalidate any existing timer
        playSound(name: "breathing", extensionFile: "mp3")
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if progress < 20.0 {
                progress += 1.0
            } else {
                timer?.invalidate()
                stopSound()
            }
        }
//        if progress == 30 {
//
//        }
    }
    func getBreathText(for progress: Double) -> String {

        if (progress <= 5) || (progress > 10 && progress <= 15) || (progress > 20 && progress <= 25) {
            return "Breath in"
        } else if (progress > 5 && progress <= 10) || (progress > 15 && progress <= 20) || (progress > 25 && progress <= 30) {
            return "Breath out"
        } else {
            return ""
        }
    }
}

#Preview {
    MeditationS3(quest: Quest.empty)
}
