//
//  MeditationS2.swift
//  SpeechAI
//
//  Created by Heical Chandra on 25/06/24.
//

import SwiftUI
import DotLottie

struct MeditationS2: View {
    let quest: Quest
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
                    Text("STEP 2")
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
                    Text("Relax yourself")
                        .multilineTextAlignment(.center)
                        .padding()
                }
                .padding(.top, 70)
                Spacer()
            VStack {
                NavigationLink(destination: MeditationS3(quest: quest)){
                Text("OK, continue")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.biruBTNBefore)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                HStack{
                    Rectangle()
                        .fill(Color.abu)
                        .frame(width: 35,height: 5)
                        .cornerRadius(25)
                    Rectangle()
                        .fill(Color.biruTuaSlider)
                        .frame(width: 35,height: 5)
                        .cornerRadius(25)
                    Rectangle()
                        .fill(Color.abu)
                        .frame(width: 35,height: 5)
                        .cornerRadius(25)
                }
                .padding(5)
            }
            .padding()
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    MeditationS2(quest: Quest.empty)
}
