//
//  JournalS8.swift
//  SpeechAI
//
//  Created by Heical Chandra on 26/06/24.
//

import SwiftUI

struct JournalS8: View {
    let quest: Quest
    var body: some View {
        TemplateJournal(number: 8, title: "Describe what it feels like to feel safe, supported, and protected.", isActive: 8, destination: CongratsView(quest: quest))
            .navigationBarBackButtonHidden(true)    }
}

#Preview {
    JournalS8(quest: Quest.empty)
}
