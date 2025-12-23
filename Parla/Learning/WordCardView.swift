//
//  WordCardView.swift
//  Parla
//
//  Created by Konstantin Safronov on 22.12.2025.
//

import SwiftUI

struct WordCardView: View {
  
  let word: Word
  let hiddenSide: HiddenSide
  @State var showsAllContent: Bool = false
  
  var body: some View {
    VStack(spacing: 16) {
      if showsAllContent {
        Text(word.value)
          .font(.largeTitle.bold())
        Text(word.translation)
          .font(.title2)
          .foregroundStyle(.secondary)
      } else {
        if hiddenSide == .word {
          Text("••••••")
            .font(.largeTitle.bold())
          
          Text(word.translation)
            .font(.title2)
            .foregroundStyle(.secondary)
        } else {
          Text(word.value)
            .font(.largeTitle.bold())
          
          Text("••••••")
            .font(.title2)
            .foregroundStyle(.secondary)
        }
      }
    }
    .frame(maxWidth: .infinity, maxHeight: 260)
    .background {
      LiquidGlassView()
    }
    .onTapGesture {
      showsAllContent = !showsAllContent
    }
  }
}
