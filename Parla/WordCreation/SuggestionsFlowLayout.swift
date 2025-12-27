//
//  SuggestionsFlowLayout.swift
//  Parla
//
//  Created by Konstantin Safronov on 26.12.2025.
//

import SwiftUI

struct SuggestionsFlowLayout: View {
  var items: [AnyView]
  var spacing: CGFloat = 8
  
  var body: some View {
    GeometryReader { geometry in
      self.generateContent(in: geometry)
    }
  }
  
  private func generateContent(in geometry: GeometryProxy) -> some View {
    var width = CGFloat.zero
    var height = CGFloat.zero
    
    return ZStack(alignment: .topLeading) {
      ForEach(0..<items.count, id: \.self) { index in
        items[index]
          .padding(.all, spacing / 2)
          .alignmentGuide(.leading) { d in
            if abs(width - d.width) > geometry.size.width {
              width = 0
              height -= d.height
            }
            let result = width
            if index == items.count - 1 {
              width = 0
            } else {
              width -= d.width
            }
            return result
          }
          .alignmentGuide(.top) { d in
            let result = height
            if index == items.count - 1 {
              height = 0
            }
            return result
          }
      }
    }
  }
}
