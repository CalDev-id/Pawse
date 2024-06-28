//
//  ChallangeS4.swift
//  SpeechAI
//
//  Created by Heical Chandra on 25/06/24.
//

import SwiftUI
import DotLottie

struct ChallangeS4: View {
    let quest: Quest
    
    var body: some View {
        VStack{
            VStack{
                Text("CHALLENGE")
                    .bold()
                    .multilineTextAlignment(.center)
                    .font(.title)
                Text("follow the steps to calm yourself")
                    .multilineTextAlignment(.center)
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
                    .font(.caption)
                Text("STEP 4")
                    .bold()
                    .multilineTextAlignment(.center)
                    .font(.title3)
                    .padding()
                DotLottieAnimation(
                    fileName: "bau",
                    config: AnimationConfig(autoplay: true, loop: true)
                )
                .view()
                .frame(width: 300, height: 300)
                Text("Continue by naming 2 \n smells you can smell.")
                    .multilineTextAlignment(.center)
                    .padding()
                    .font(.title3)
            }
            .padding(.top, 60)
            Spacer()
            VStack {
                NavigationLink(destination: ChallangeS5(quest: quest)){
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
                    Rectangle()
                        .fill(Color.abu)
                        .frame(width: 35,height: 5)
                        .cornerRadius(25)
                }
                .padding(5)
            }
            .padding()
        }
    }
}

#Preview {
    ChallangeS4(quest: Quest.empty)
}
