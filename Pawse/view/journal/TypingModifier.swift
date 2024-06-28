//
//  TypingModifier.swift
//  Task Manager
//
//  Created by Kevin Fairuz on 24/06/24.
//

import SwiftUI

struct TypingTextModifier: AnimatableModifier {
    var percentage: CGFloat = 0
    var text: String

    var animatableData: CGFloat {
        get { percentage }
        set { percentage = newValue }
    }

    func body(content: Content) -> some View {
        Text(String(text.prefix(Int(percentage * CGFloat(text.count)))))
            .animation(nil)
    }
}

extension View {
    func typingText(percentage: CGFloat, text: String) -> some View {
        self.modifier(TypingTextModifier(percentage: percentage, text: text))
    }
}

