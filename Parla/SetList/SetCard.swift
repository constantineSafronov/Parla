//
//  SetCard.swift
//  Parla
//
//  Created by Konstantin Safronov on 20.12.2025.
//

import SwiftUI

struct SetCard: View {
  let set: WordSet
  
  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      HStack() {
        Text(set.emoji)
          .font(.largeTitle)
        Spacer()
        Text("\(set.words.count)")
          .font(.subheadline)
          .foregroundStyle(.secondary)
      }
      
      Text(set.title)
        .font(.headline)
      
      Text(set.subtitle)
        .font(.subheadline)
        .foregroundStyle(.secondary)
    }
    .padding()
    .frame(maxWidth: .infinity, minHeight: 140, alignment: .leading)
    .background {
      LiquidGlassView()
    }
  }
}
