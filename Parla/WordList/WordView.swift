//
//  WordItem.swift
//  Parla
//
//  Created by Konstantin Safronov on 21.12.2025.
//

import SwiftUI

struct WordView: View {
  let word: Word
  
  var body: some View {
    ZStack {
      if word.isLearned {
        Color.green.opacity(0.45)
          .cornerRadius(24)
      }
      LiquidGlassView()
      VStack(alignment: .center, spacing: 12) {
        Text(word.value)
          .font(.title)
        
        Text(word.translation)
          .font(.footnote)
      }
      .padding(.vertical)
    }
  }
}
