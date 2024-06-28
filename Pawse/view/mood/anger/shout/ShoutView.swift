//
//  ShoutView.swift
//  Pawse
//
//  Created by hendra on 25/06/24.
//

import SwiftUI

struct ShoutView: View {
    let quest: Quest
    @StateObject private var audioDetector = AudioDetector()
    @ObservedObject private var shoutViewModel = ShoutViewModel()

    var body: some View {
        VStack {
            VStack(spacing: 8) {
                Text("SHOUT")
                    .font(.title)
                    .fontWeight(.bold)
                Text("shout as much as you can to release your anger")
                    .font(.caption)
            }
            ZStack {
                CapsuleView(currentLevel: $audioDetector.currentLevel)
                    .frame(width: 50, height: 360)
                    .padding([.top, .bottom], 60)
                    .overlay {
                        Capsule()
                            .fill(.gray)
                            .opacity(0.3)
                            .frame(width: 50, height: 360)
                    }
                    .rotationEffect(.degrees(180))
                VStack {
                    Image("full-angry")
                        .resizable()
                        .frame(width: 100, height: 80)
                        .overlay(
                            Rectangle()
                                .frame(height: 5)
                                .foregroundColor(Color.yellow)
                                .offset(y: 60)
                        )
                    Spacer()
                    Image("angry")
                        .resizable()
                        .frame(width: 100, height: 80)
                }
                .frame(height: 400)
            }
            
            
            if audioDetector.isSuccess {
                Button {
                    shoutViewModel.navigateToCongratsView = true
                } label: {
                    Text("Done")
                        .foregroundStyle(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.biruTuaSlider)
                        .cornerRadius(16)
                }
            } else {
                Button {
                    audioDetector.startMonitoring()
                } label: {
                    VStack(spacing: 16) {
                        Image("microfon")
                            .overlay(
                                RoundedRectangle(cornerRadius: 200)
                                    .stroke(Color(red: 1, green: 0.73, blue: 0.25).opacity(0.3), lineWidth: 4)
                            )
                        Text("tap to shout out")
                            .font(.caption2)
                            .foregroundStyle(.gray)
                    }
                }
            }
        }
        .padding()
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $shoutViewModel.navigateToCongratsView, destination: {
            CongratsView(quest: quest)
        })
    }
}

struct CapsuleView: View {
    @Binding var currentLevel: Float

    private let minLevel: Float = -160.0
    private let maxLevel: Float = 0

    var body: some View {
        GeometryReader { geometry in
            Capsule()
                .fill(.biruBTN)
                .frame(height: height(for: geometry.size.height))
        }
    }

    private func height(for totalHeight: CGFloat) -> CGFloat {
        let normalizedLevel = (currentLevel - minLevel) / (maxLevel - minLevel)
        return max(0, min(pow(CGFloat(normalizedLevel), 2) * totalHeight, totalHeight))
    }
}

#Preview {
    ShoutView(quest: Quest.empty)
}
