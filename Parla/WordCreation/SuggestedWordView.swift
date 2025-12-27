//
//  SuggestedWordView.swift
//  Parla
//
//  Created by Konstantin Safronov on 26.12.2025.
//

import SwiftUI

struct SuggestedWordView: View {
  
  private var suggestedWord: (String, String)
  
  init(suggestedWord: (String, String)) {
    self.suggestedWord = suggestedWord
  }
  
  var body: some View {
    VStack(spacing: 2) {
      Text(suggestedWord.0)
        .lineLimit(1)
        .font(.title3)
        .fixedSize()
      Text(suggestedWord.1)
        .lineLimit(1)
        .font(.footnote)
        .fixedSize()
    }
    .padding(.horizontal, 12)
    .padding(.vertical, 6)
    .background(LiquidGlassView())
    .fixedSize()
  }
}
