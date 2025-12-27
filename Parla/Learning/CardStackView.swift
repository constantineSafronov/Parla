//
//  CardStackView.swift
//  Parla
//
//  Created by Konstantin Safronov on 22.12.2025.
//

import SwiftUI

extension View {
  @ViewBuilder
  func `if`<Content: View>(
    _ condition: Bool,
    transform: (Self) -> Content
  ) -> some View {
    if condition {
      transform(self)
    } else {
      self
    }
  }
}

struct CardStackView: View {
  
  private let numberOfCards = 3
  
  let words: [Word]
  let hiddenSide: HiddenSide
  let onSwipe: (Word, SwipeResult) -> Void
  let voiceOverCallback: ((String) -> Void)
  
  var body: some View {
    ZStack {
      ForEach(
        Array(words.prefix(numberOfCards).enumerated()),
        id: \.element.value
      ) { index, word in
        card(for: word, at: index)
      }
    }
  }
  
  @ViewBuilder
  private func card(for word: Word, at index: Int) -> some View {
    WordCardView(word: word, hiddenSide: hiddenSide) {
      voiceOverCallback(word.value)
    }
    .padding(.horizontal)
    .scaleEffect(1 - CGFloat(index) * 0.05)
    .offset(y: CGFloat(index) * 12)
    .zIndex(Double(numberOfCards - index))
    .allowsHitTesting(index == 0)
    .if(index == 0) {
      $0.modifier(
        SwipeCardModifier(
          onSwipeLeft: {
            onSwipe(word, .unknown)
          },
          onSwipeRight: {
            onSwipe(word, .known)
          }
        )
      )
    }
    .animation(.spring(response: 0.5, dampingFraction: 0.7), value: index)
  }
}
