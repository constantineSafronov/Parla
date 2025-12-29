//
//  CreateWordSet.swift
//  Parla
//
//  Created by Konstantin Safronov on 20.12.2025.
//

import SwiftUI
import SwiftData

struct CreateWordSet: View {
  
  @Environment(\.dismiss) private var dismiss
  @Environment(\.appEnvironment) private var environment
  @State private var title = ""
  @State private var description = ""
  @State private var emoji = "📚"
  @State private var showEmojiPicker = false
  
  var onCreate: (WordSet) -> Void
  
  var body: some View {
    NavigationStack {
      VStack(spacing: 24) {
        
        Button {
          showEmojiPicker = true
        } label: {
          Text(emoji)
            .font(.system(size: 64))
            .frame(width: 96, height: 96)
            .background {
              LiquidGlassView()
            }
        }
        TextField(LocalizedStrings.CreateWordSet.name.localized, text: $title)
          .font(.title2)
          .onChange(of: title, initial: true, { _, value in
            autoSuggestEmojiIfNeeded(from: value)
          })
        TextField(LocalizedStrings.CreateWordSet.description.localized, text: $description, axis: .vertical)
          .foregroundStyle(.secondary)
        
        Spacer()
      }
      .padding()
      .navigationTitle(LocalizedStrings.CreateWordSet.title.localized)
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button(LocalizedStrings.Common.cancel.localized) {
            dismiss()
          }
        }
        
        ToolbarItem(placement: .confirmationAction) {
          Button(LocalizedStrings.Common.create.localized) {
            let set = WordSet(
              title: title,
              subtitle: description,
              emoji: emoji
            )
            onCreate(set)
            dismiss()
          }
          .disabled(title.isEmpty)
        }
      }
      .sheet(isPresented: $showEmojiPicker) {
        EmojiPickerView(selectedEmoji: $emoji)
          .presentationBackground(environment.styleService.commonBackgroundGradient)
      }
    }
  }
  
  private func autoSuggestEmojiIfNeeded(from title: String) {
    let lowercased = title.lowercased()
    
    if lowercased.contains("food") { emoji = "🍕" }
    else if lowercased.contains("travel") { emoji = "✈️" }
    else if lowercased.contains("shop") { emoji = "🛍️" }
    else if lowercased.contains("music") { emoji = "🎵" }
    else if lowercased.contains("emozion") { emoji = "😀" }
    else { emoji = "📚" }
  }
}
