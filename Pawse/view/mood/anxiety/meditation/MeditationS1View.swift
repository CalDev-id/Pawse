//
//  MeditationS1View.swift
//  SpeechAI
//
//  Created by Heical Chandra on 21/06/24.
//

import SwiftUI
import DotLottie

struct MeditationS1View: View {
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
                    Text("STEP 1")
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
                    Text("Sit and position yourself in a \n comfortable place")
                        .multilineTextAlignment(.center)
                        .padding()
                }
                .padding(.top, 70)
    //            Text(String(Int(progress)))

                Spacer()
            VStack {
                NavigationLink(destination: MeditationS2(quest: quest)){
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
                        .fill(Color.biruTuaSlider)
                        .frame(width: 35,height: 5)
                        .cornerRadius(25)
                    Rectangle()
                        .fill(Color.abu)
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
    MeditationS1View(quest: .empty)
}
