//
//  WatchCardLearningView.swift
//  Parla
//
//  Created by Konstantin Safronov on 30.12.2025.
//

import SwiftUI
import Observation

struct WatchCardLearningView: View {
  
  @Bindable private var store = WatchDataStore.shared
  
  var body: some View {
    VStack(spacing: 12) {
      if let word = store.currentWord {
        Text(word.value)
          .font(.title3)
          .bold()
        
        Text(word.translation)
          .font(.footnote)
          .foregroundStyle(.secondary)
      } else {
        Text(LocalizedStrings.WatchCardLearning.watchCardPlaceholder.localized)
          .foregroundStyle(.secondary)
          .padding()
      }
      if store.currentWord != nil {
        HStack {
          Button(LocalizedStrings.WatchCardLearning.watchCardUnKnown.localized) {
            store.markUnknown()
          }
          .tint(.red)
          Button(LocalizedStrings.WatchCardLearning.watchCardKnown.localized) {
            store.markKnown()
          }
          .tint(.green)
        }
      }
    }
    .padding()
    .background {
      LinearGradient(
        colors: [Color.blue.opacity(0.4), Color.purple.opacity(0.4)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
      )
      .ignoresSafeArea()
    }
    .cornerRadius(12)
  }
}
