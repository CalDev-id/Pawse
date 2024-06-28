//
//  JournalS6.swift
//  SpeechAI
//
//  Created by Heical Chandra on 26/06/24.
//

import SwiftUI

struct JournalS6: View {
    let quest: Quest
    var body: some View {
        TemplateJournal(number: 6, title: "What are 3 things you can do to improve your mental health?", isActive: 6, destination: JournalS7(quest: quest))
            .navigationBarBackButtonHidden(true)    }
}

#Preview {
    JournalS6(quest: Quest.empty)
}
