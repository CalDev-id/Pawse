//
//  AudioDetector.swift
//  Pawse
//
//  Created by hendra on 25/06/24.
//

import Foundation
import AVFAudio

class AudioDetector: ObservableObject {
    private var audioRecorder: AVAudioRecorder!
    private var timer: Timer?

    @Published var isSuccess = false
    @Published var currentLevel: Float = -160.0

    private let loudnessThreshold: Float = -3

    init() {
        requestMicrophoneAccess()
    }
    
    private func requestMicrophoneAccess() {
        if #available(iOS 17.0, *) {
            AVAudioApplication.requestRecordPermission { [weak self] granted in
                DispatchQueue.main.async {
                    if granted {
                        self?.setupAudioRecorder()
                    } else {
                        print("Microphone access denied")
                        // Handle the case when the user denies microphone access
                    }
                }
            }
        } else {
            AVAudioSession.sharedInstance().requestRecordPermission { [weak self] granted in
                DispatchQueue.main.async {
                    if granted {
                        self?.setupAudioRecorder()
                    } else {
                        print("Microphone access denied")
                        // Handle the case when the user denies microphone access
                    }
                }
            }
        }
    }

    private func setupAudioRecorder() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker, .allowBluetooth])
            try audioSession.setActive(true)

            let settings: [String: Any] = [
                AVFormatIDKey: kAudioFormatAppleLossless,
                AVSampleRateKey: 44100.0,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue
            ]

            audioRecorder = try AVAudioRecorder(url: URL(fileURLWithPath: "/dev/null"), settings: settings)
            audioRecorder.isMeteringEnabled = true
            audioRecorder.prepareToRecord()
        } catch {
            print("Failed to set up audio recorder: \(error)")
        }
    }

    public func startMonitoring() {
        audioRecorder.record()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.checkAudioLevel()
        }
    }

    private func checkAudioLevel() {
        audioRecorder.updateMeters()
        let averagePower = audioRecorder.averagePower(forChannel: 0)
        DispatchQueue.main.async {
            self.currentLevel = averagePower
            if averagePower > self.loudnessThreshold {
                self.isSuccess = true
                self.stopMonitoring()
            }
        }
    }
    
    private func stopMonitoring() {
        audioRecorder.stop()
        timer?.invalidate()
        timer = nil
    }

    deinit {
        audioRecorder.stop()
        timer?.invalidate()
    }
}
