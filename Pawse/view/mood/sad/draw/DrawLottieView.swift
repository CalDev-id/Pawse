//
//  DrawLottieView.swift
//  Pawse
//
//  Created by hendra on 25/06/24.
//

import SwiftUI
import DotLottie

struct DrawLottieView: View {
    let quest: Quest
    var body: some View {
        VStack {
            DotLottieAnimation(
                fileName: "lukis",
                config: AnimationConfig(autoplay: true, loop: true)
            )
            .view()
            .frame(width: 300, height: 300)
            .padding([.top], 80)
            .padding([.bottom], 40)
            Text("DRAW")
                .font(.title)
                .bold()
                .padding(.bottom, 20)
            Text("Art is an immediate mood-booster, and it fosters feelings of relaxation, creativity, and inspiration so draw anything you want between 10 minutes")
                .font(.callout)
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing], 60)
            Spacer()
            NavigationLink(destination: DrawView(quest: quest), label: {
                Text("Start")
                    .foregroundStyle(.white)
                    .frame(minWidth: 180, minHeight: 60)
                    .background(.biruBTN)
            })
            .cornerRadius(16)
            .padding()
            
        }
        .padding()
        .navigationBarBackButtonHidden()
    }
}

//#Preview {
//    DrawLottieView()
//}
