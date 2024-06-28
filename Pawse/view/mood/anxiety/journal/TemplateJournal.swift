//
//  TemplateJournal.swift
//  SpeechAI
//
//  Created by Heical Chandra on 26/06/24.
//

import SwiftUI
import Speech

struct TemplateJournal<Destination: View>: View {
    let number: Int
    let title: String
    let isActive: Int
    let destination: Destination
    
    @ObservedObject var speechRecognizer = SpeechRecognizer()
    @State private var jurnal: String = ""
    @State private var isRecord: Bool = false
    @State private var showResultSheet: Bool = false
    
    var body: some View {
            VStack {
                VStack{
                    Text("JOURNAL")
                        .bold()
                        .multilineTextAlignment(.center)
                        .font(.title)
                    Text("answer all the questions.")
                        .multilineTextAlignment(.center)
                        .fontWeight(.medium)
                        .font(.caption)
                        .padding(.bottom, 1)
                        .foregroundColor(.gray)
                    Text(String(number))
                        .bold()
                        .multilineTextAlignment(.center)
                        .font(.system(size: 32))
                    Text(title)
                        .bold()
                        .multilineTextAlignment(.center)
                        .font(.system(size: 24))
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
                VStack {
                    NavigationLink(destination: destination){
                    Text("Next")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.biruBTNBefore)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    HStack{
                        Rectangle()
                            .fill(isActive == 1 ? Color.biruTuaSlider : Color.abu)
                            .frame(width: 35,height: 5)
                            .cornerRadius(25)
                        Rectangle()
                            .fill(isActive == 2 ? Color.biruTuaSlider : Color.abu)
                            .frame(width: 35,height: 5)
                            .cornerRadius(25)
                        Rectangle()
                            .fill(isActive == 3 ? Color.biruTuaSlider : Color.abu)
                            .frame(width: 35,height: 5)
                            .cornerRadius(25)
                        Rectangle()
                            .fill(isActive == 4 ? Color.biruTuaSlider : Color.abu)
                            .frame(width: 35,height: 5)
                            .cornerRadius(25)
                        Rectangle()
                            .fill(isActive == 5 ? Color.biruTuaSlider : Color.abu)
                            .frame(width: 35,height: 5)
                            .cornerRadius(25)
                        Rectangle()
                            .fill(isActive == 6 ? Color.biruTuaSlider : Color.abu)
                            .frame(width: 35,height: 5)
                            .cornerRadius(25)
                        Rectangle()
                            .fill(isActive == 7 ? Color.biruTuaSlider : Color.abu)
                            .frame(width: 35,height: 5)
                            .cornerRadius(25)
                        Rectangle()
                            .fill(isActive == 8 ? Color.biruTuaSlider : Color.abu)
                            .frame(width: 35,height: 5)
                            .cornerRadius(25)
                        
                    }
                    .padding(5)
                }
                .padding(.horizontal)
            }
            .padding(.horizontal)
            .onAppear {
                requestSpeechAuthorization()
            }
            .onReceive(speechRecognizer.$transcript) { newTranscript in
                self.jurnal = newTranscript
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
    TemplateJournal(number: 1, title: "ayam", isActive: 1, destination: JournalS2(quest: Quest.empty))
}
