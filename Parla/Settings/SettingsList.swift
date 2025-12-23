//
//  SettingsList.swift
//  Parla
//
//  Created by Konstantin Safronov on 22.12.2025.
//

import SwiftUI

struct SettingsList: View {
  
  @Environment(StyleService.self) private var styleService
  @AppStorage(AppSettingsKey.appTheme) private var appTheme: AppTheme = .system
  @AppStorage(AppSettingsKey.hiddenSide) private var hiddenSide: HiddenSide = .translation
  
  var body: some View {
    ScrollView {
      VStack(spacing: 24) {
        SettingsSection(title: LocalizedStrings.Settings.appearanceTitle.localized, icon: "paintbrush") {
          Picker(LocalizedStrings.Settings.appearanceThemePickerTitle.localized, selection: $appTheme) {
            ForEach(AppTheme.allCases) { theme in
              Text(theme.title).tag(theme)
            }
          }
          .pickerStyle(.segmented)
        }
        
        SettingsSection(title: LocalizedStrings.Settings.learningTitle.localized, icon: "eye.slash") {
          Picker(LocalizedStrings.Settings.learningHiddenSidePickerTitle.localized, selection: $hiddenSide) {
            ForEach(HiddenSide.allCases) { side in
              Text(side.title).tag(side)
            }
          }
          .pickerStyle(.segmented)
          
          Text(LocalizedStrings.Settings.learningDescription.localized)
            .font(.footnote)
            .foregroundStyle(.secondary)
        }
        
        Spacer()
      }
      .padding()
    }
    .navigationTitle(LocalizedStrings.Settings.title.localized)
    .background {
      styleService.commonBackgroundGradient
      .ignoresSafeArea()
    }
  }
}
