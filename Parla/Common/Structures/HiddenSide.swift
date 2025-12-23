//
//  HiddenSide.swift
//  Parla
//
//  Created by Konstantin Safronov on 22.12.2025.
//

import Foundation

enum HiddenSide: String, CaseIterable, Identifiable {
  case word
  case translation
  
  var id: String { rawValue }
  
  var title: String {
    switch self {
    case .word: return LocalizedStrings.Settings.learningHiddenSideHideWord.localized
    case .translation: return LocalizedStrings.Settings.learningHiddenSideHideTranslation.localized
    }
  }
}
