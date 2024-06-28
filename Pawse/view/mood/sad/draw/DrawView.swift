//
//  DrawView.swift
//  Pawse
//
//  Created by hendra on 25/06/24.
//

import SwiftUI

struct Line {
    var points = [CGPoint]()
    var color: Color = .black
    var lineWidth: Double = 4
}

struct DrawView: View {
    let quest: Quest
    @State private var currentLine = Line()
    @State private var lines: [Line] = []
    @State private var replacement: Color = .black
    @State private var timerRunning = true
    @State private var timeRemaining = 300
    
    
    @ObservedObject private var drawViewModel = DrawViewModel()
    
    var body: some View {
        VStack {
            Canvas { context, size in
                for line in lines {
                    var path = Path()
                    path.addLines(line.points)
                    context.stroke(path, with: .color(line.color), lineWidth: line.lineWidth)
                }
            }
            .border(Color.black)
            .colorEffect(ShaderLibrary.recolor(.color(replacement)))
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onChanged({ value in
                    let newPoint = value.location
                    if var currentLine = lines.last {
                        currentLine.points.append(newPoint)
                        lines[lines.count - 1] = currentLine
                    } else {
                        lines.append(Line(points: [newPoint], color: replacement))
                    }
                    
                })
                    .onEnded({ value in
                        lines.append(Line(points: [], color: replacement))
                    })
            )
            ColorPicker(selection: $replacement) {
                Text("Change Color")
            }
            .padding()
            Button{
                lines = []
            } label: {
                Text("Clear")
                    .foregroundStyle(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .cornerRadius(16)
            }
            .padding()
            
            if timeRemaining > 0 {
                ProgressView(value: Double(timeRemaining), total: 600)
                    .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                    .padding()
            } else {
                Button {
                    drawViewModel.navigateToCongratsView = true
                } label: {
                    Text("Done")
                        .foregroundStyle(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.green)
                        .cornerRadius(16)
                }
//                    NavigationLink(destination: MoodView()) {
//
//                    }
//                    .padding()
            }
        }
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $drawViewModel.navigateToCongratsView) {
            CongratsView(quest: quest)
        }
        .onAppear(perform: startTimer)
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    Button {
                        if lines.count != 0 {
                            lines.removeLast()
                        }
                    } label: {
                        Image(systemName: "arrow.uturn.backward.circle.fill")
                            .foregroundStyle(.blue)
                    }
                }
            }
        })
    }
    
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                timer.invalidate()
                self.timerRunning = false
            }
        }
    }

    private func timeFormatted(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
    

struct DrawView_Previews: PreviewProvider {
    static var previews: some View {
        DrawView(quest: .empty)
    }
}
