//
//  PunchView.swift
//  Pawse
//
//  Created by hendra on 26/06/24.
//

import SwiftUI
import CoreHaptics

struct PunchView: View {
    @State private var navigateToCongratsView = false
    var quest: Quest
    @State private var punches = 0
    @State private var timeRemaining = 30
    @State private var targetPosition = CGPoint(x: 100, y: 100)
    @State private var gameStarted = false
    @State private var gameCompleted = false
    @State private var engine: CHHapticEngine?
    @State private var timer: Timer?

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack {
                Text("Punches: \(punches)")
                    .font(.largeTitle)
                    .padding()

                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .padding()
                
                Spacer()
                
                if gameCompleted {
                    Button{
                        navigateToCongratsView = true
                    }  label: {
                        Text("Complete")
                            .font(.title)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                } else {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 50, height: 50)
                        .position(targetPosition)
                        .onTapGesture {
                            punch()
                        }
                }
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $navigateToCongratsView, destination: {
            CongratsView(quest: quest)
        })
        .onAppear(perform: startGame)
    }

    func startGame() {
        gameStarted = true
        gameCompleted = false
        punches = 0
        timeRemaining = 30
        targetPosition = randomPosition()
        startHaptics()
        startTimer()
    }

    func punch() {
        if gameStarted {
            punches += 1
            triggerHaptic()
            targetPosition = randomPosition()
            
            if punches >= 10 {
                gameStarted = false
                gameCompleted = true
                timer?.invalidate()
            }
        }
    }

    func randomPosition() -> CGPoint {
        let frameWidth: CGFloat = 400
        let frameHeight: CGFloat = 400

        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height

        let xMin = (screenWidth - frameWidth) / 2
        let xMax = xMin + frameWidth

        let yMin = (screenHeight - frameHeight) / 2
        let yMax = yMin + frameHeight

        let x = CGFloat.random(in: xMin...(xMax - 50))
        let y = CGFloat.random(in: yMin...(yMax - 50))

        return CGPoint(x: x, y: y)
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer.invalidate()
                gameStarted = false
                gameCompleted = true
            }
        }
    }

    func startHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }

    func triggerHaptic() {
        guard let engine = engine else { return }
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        do {
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
}

struct PunchView_Previews: PreviewProvider {
    static var previews: some View {
        PunchView(quest: Quest.empty)
    }
}
