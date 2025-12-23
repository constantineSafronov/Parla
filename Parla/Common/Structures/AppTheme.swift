//
//  AppTheme.swift
//  Parla
//
//  Created by Konstantin Safronov on 22.12.2025.
//

import SwiftUI

enum AppTheme: String, CaseIterable, Identifiable {
  case system
  case light
  case dark
  
  var id: String { rawValue }
  
  var title: String {
    switch self {
    case .system: return LocalizedStrings.AppTheme.system.localized
    case .light: return LocalizedStrings.AppTheme.light.localized
    case .dark: return LocalizedStrings.AppTheme.dark.localized
    }
  }
  
  var colorScheme: ColorScheme? {
    switch self {
    case .system: return nil
    case .light: return .light
    case .dark: return .dark
    }
  }
}
