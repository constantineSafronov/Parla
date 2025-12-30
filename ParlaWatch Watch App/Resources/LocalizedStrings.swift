//
//  LocalizedStrings.swift
//  ParlaWatch Watch App
//
//  Created by Konstantin Safronov on 30.12.2025.
//

import Foundation

protocol Localizable: RawRepresentable where RawValue == String {}

extension Localizable {
    var localized: String {
        NSLocalizedString(rawValue, bundle: .main, comment: "")
    }
}

enum LocalizedStrings {
  
  enum WatchCardLearning: String, Localizable {
    case watchCardPlaceholder = "watch_card_learing.placeholder"
    case watchCardKnown = "watch_card_learing.known"
    case watchCardUnKnown = "watch_card_learing.unknown"
  }
}
