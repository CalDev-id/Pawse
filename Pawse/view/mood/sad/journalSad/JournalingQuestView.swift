//
//  SharingView.swift
//  SpeechAI
//
//  Created by Heical Chandra on 23/06/24.
//

import SwiftUI
import Speech

struct JournalingQuestView: View {
    let quest: Quest
    @ObservedObject var speechRecognizer = SpeechRecognizer()
    @State private var jurnal: String = ""
    @State private var isRecord: Bool = false
    @State private var showResultSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack{
                    Text("JOURNALLING")
                        .bold()
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .padding(.bottom, 10)
                    Text("Tell me 3 good things that happen today, \n reflecting on your day will allow you to notice all the smaller moments that were actually quite special.")
                        .multilineTextAlignment(.center)
                        .fontWeight(.medium)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.bottom, 10)
                    
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $jurnal)
                            .frame(height: 336)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray, lineWidth: 2)
                            )

                        if jurnal.isEmpty {
                            Text("Start writing...")
                                .foregroundColor(.gray)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 18)
                        }
                    }
                }
                .padding()
                .padding(.top, 10)
                if !isRecord {
                    VStack {
                        Button(action: {
                            self.speechRecognizer.startTranscribing()
                            isRecord.toggle()
                        }) {
                            Image("microfon")
                                .overlay(
                                    RoundedRectangle(cornerRadius: 200)
                                        .stroke(Color.cream, lineWidth: 4)
                                )
                    }
                        Text("tap to talk")
                            .fontWeight(.medium)
                            .foregroundColor(.gray)
                    }
                } else {
                    VStack {
                        Button(action: {
                            self.speechRecognizer.stopTranscribing()
                            self.jurnal = self.speechRecognizer.transcript
                            isRecord.toggle()
                        }) {
                            Image("endRecord")
                                .overlay(
                                    RoundedRectangle(cornerRadius: 200)
                                        .stroke(Color.cream, lineWidth: 4)
                                )
                    }
                        Text("tap to stop")
                            .fontWeight(.medium)
                            .foregroundColor(.gray)
                    }
                }
                Spacer()
                NavigationLink(destination: CongratsView(quest: quest)){
                    Text("Done")
                        .fontWeight(.semibold)
                        .frame(width: 183,height: 63)
                        .background(Color.biruTuaSlider)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
            .padding()
            .onAppear {
                requestSpeechAuthorization()
            }
            .onReceive(speechRecognizer.$transcript) { newTranscript in
                self.jurnal = newTranscript
            }
//            .sheet(isPresented: $showResultSheet) {
//                EmoResultView(jurnal: jurnal)
//            }
        }
    }
    
    func requestSpeechAuthorization() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            switch authStatus {
            case .authorized:
                print("Speech recognition authorized")
            case .denied:
                print("Speech recognition denied")
            case .restricted:
                print("Speech recognition restricted")
            case .notDetermined:
                print("Speech recognition not determined")
            @unknown default:
                print("Unknown status")
            }
        }
    }
}

#Preview {
    JournalingQuestView(quest: .empty)
}
