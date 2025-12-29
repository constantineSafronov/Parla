//
//  SettingsListViewModel.swift
//  Parla
//
//  Created by Konstantin Safronov on 29.12.2025.
//

import SwiftUI
import Observation

@Observable
final class SettingsListViewModel {
  
  var appTheme: AppTheme {
    didSet { UserDefaults.standard.set(appTheme.rawValue, forKey: AppSettingsKey.appTheme) }
  }
  
  var hiddenSide: HiddenSide {
    didSet { UserDefaults.standard.set(hiddenSide.rawValue, forKey: AppSettingsKey.hiddenSide) }
  }
  
  var repeatingPeriod: RepeatingPeriod {
    didSet { UserDefaults.standard.set(repeatingPeriod.rawValue, forKey: AppSettingsKey.repeatingPeriod) }
  }
  
  init() {
    let rawTheme = UserDefaults.standard.string(forKey: AppSettingsKey.appTheme) ?? ""
    self.appTheme = AppTheme(rawValue: rawTheme) ?? .system
    
    let rawSide = UserDefaults.standard.string(forKey: AppSettingsKey.hiddenSide) ?? ""
    self.hiddenSide = HiddenSide(rawValue: rawSide) ?? .translation
    
    let rawPeriod = UserDefaults.standard.string(forKey: AppSettingsKey.repeatingPeriod) ?? ""
    self.repeatingPeriod = RepeatingPeriod(rawValue: rawPeriod) ?? .never
  }
}
