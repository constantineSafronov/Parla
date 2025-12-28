//
//  Mem.swift
//  Parla
//
//  Created by Konstantin Safronov on 28.12.2025.
//

enum RepeatingPeriod: String, CaseIterable, Identifiable {
  case threeMonths
  case sixMonths
  case never
  
  var id: String { rawValue }
  
  var title: String {
    switch self {
    case .threeMonths: return LocalizedStrings.Settings.learningRepeatingPeriodThreeMonths.localized
    case .sixMonths: return LocalizedStrings.Settings.learningRepeatingPeriodSixMonths.localized
    case .never: return LocalizedStrings.Settings.learningRepeatingPeriodNever.localized
    }
  }
}
