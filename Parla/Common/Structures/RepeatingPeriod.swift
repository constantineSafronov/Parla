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

extension RepeatingPeriod {
  var policyTerm: Int {
    switch self {
    case .never: return Int.max
    case .threeMonths: return 3
    case .sixMonths: return 6
    }
  }
}
