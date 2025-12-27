//
//  StyleService.swift
//  Parla
//
//  Created by Konstantin Safronov on 23.12.2025.
//

import SwiftUI
import Observation

@Observable
final class StyleService {
  var commonBackgroundGradient: LinearGradient {
    LinearGradient(
      colors: [Color.blue.opacity(0.4), Color.purple.opacity(0.4)],
      startPoint: .topLeading,
      endPoint: .bottomTrailing
    )
  }
}
