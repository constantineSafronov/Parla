//
//  SettingsSection.swift
//  Parla
//
//  Created by Konstantin Safronov on 22.12.2025.
//

import SwiftUI

struct SettingsSection<Content: View>: View {
  
  let title: String
  let icon: String
  let content: Content
  
  init(
    title: String,
    icon: String,
    @ViewBuilder content: () -> Content
  ) {
    self.title = title
    self.icon = icon
    self.content = content()
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      
      Label(title, systemImage: icon)
        .font(.headline)
      
      content
    }
    .padding()
    .background {
      LiquidGlassView()
    }
  }
}
