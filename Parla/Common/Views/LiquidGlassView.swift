//
//  LiquidGlassView.swift
//  Parla
//
//  Created by Konstantin Safronov on 20.12.2025.
//

import SwiftUI

struct LiquidGlassView: View {
  var body: some View {
    RoundedRectangle(cornerRadius: 24, style: .continuous)
      .fill(.ultraThinMaterial)
      .overlay(
        RoundedRectangle(cornerRadius: 24, style: .continuous)
          .stroke(
            LinearGradient(
              colors: [
                Color.white.opacity(0.6),
                Color.white.opacity(0.15)
              ],
              startPoint: .topLeading,
              endPoint: .bottomTrailing
            ),
            lineWidth: 1
          )
      )
      .shadow(color: .black.opacity(0.18), radius: 20, y: 10)
  }
}
