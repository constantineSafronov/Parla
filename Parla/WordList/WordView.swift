//
//  WordItem.swift
//  Parla
//
//  Created by Konstantin Safronov on 21.12.2025.
//

import SwiftUI

struct WordView: View {
  let set: Word
  
  var body: some View {
    ZStack {
      LiquidGlassView()
      VStack(alignment: .center, spacing: 12) {
        Text(set.value)
          .font(.title)
        
        Text(set.translation)
          .font(.footnote)
      }
      .padding(.vertical)
    }
  }
}
