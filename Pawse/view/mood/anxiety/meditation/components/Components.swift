//
//  Components.swift
//  SpeechAI
//
//  Created by Heical Chandra on 25/06/24.
//

import SwiftUI

struct Components: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
struct CustomProgressView: View {
    var progress: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: geometry.size.height)
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.biruTuaSlider)
                    .frame(width: CGFloat(progress / 20.0) * geometry.size.width, height: geometry.size.height)
            }
        }
    }
}
#Preview {
    Components()
}
