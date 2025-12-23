//
//  EmojiPickerView.swift
//  Parla
//
//  Created by Konstantin Safronov on 20.12.2025.
//

import SwiftUI

struct EmojiPickerView: View {
  
  @Environment(\.dismiss) private var dismiss
  @Binding var selectedEmoji: String
  
  let emojis = [
    "🍕","🍝","☕️","🍷","✈️","🏖️","🗺️","📚","📝","🎧",
    "🛍️","💶","🏠","⏰","📱","😀","😍","🤔","😅","😂",
    "🌍","🌸","🐶","🐱","🎵","🎬","🎨","⚽️","🎮","📷"
  ]
  
  private let columns = Array(repeating: GridItem(.flexible()), count: 6)
  
  var body: some View {
    VStack(spacing: 16) {
      VStack(spacing: 8) {
        Text(LocalizedStrings.EmojiPicker.title.localized)
          .font(.headline)
        
        Text(selectedEmoji)
          .font(.system(size: 48))
      }
      .padding(.top)
      
      ScrollView {
        LazyVGrid(columns: columns, spacing: 16) {
          ForEach(emojis, id: \.self) { emoji in
            EmojiCell(
              emoji: emoji,
              isSelected: emoji == selectedEmoji
            )
            .onTapGesture {
              selectedEmoji = emoji
              dismiss()
            }
          }
        }
        .padding()
      }
      .scrollIndicators(.hidden)
    }
    .padding()
    .presentationDetents([.large])
  }
}

struct EmojiCell: View {
  let emoji: String
  let isSelected: Bool
  
  var body: some View {
    Text(emoji)
      .font(.system(size: 32))
      .frame(width: 52, height: 52)
      .background {
        RoundedRectangle(cornerRadius: 14, style: .continuous)
          .fill(isSelected ? .ultraThinMaterial : .thinMaterial)
      }
      .overlay {
        if isSelected {
          RoundedRectangle(cornerRadius: 14, style: .continuous)
            .stroke(Color.white.opacity(0.6), lineWidth: 1)
        }
      }
  }
}
