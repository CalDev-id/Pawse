//
//  JournalS3.swift
//  SpeechAI
//
//  Created by Heical Chandra on 26/06/24.
//

import SwiftUI

struct JournalS3: View {
    let quest: Quest
    var body: some View {
        TemplateJournal(number: 3, title: "What are your fears?", isActive: 3, destination: JournalS4(quest: quest))
            .navigationBarBackButtonHidden(true)    }
}

#Preview {
    JournalS3(quest: Quest.empty)
}
