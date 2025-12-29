//
//  SettingsList.swift
//  Parla
//
//  Created by Konstantin Safronov on 22.12.2025.
//

import SwiftUI

struct SettingsList: View {
  
  @Environment(\.appEnvironment) private var environment
  @Bindable private var viewModel: SettingsListViewModel
  
  init(viewModel: SettingsListViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    ScrollView {
      VStack(spacing: 24) {
        SettingsSection(title: LocalizedStrings.Settings.appearanceTitle.localized, icon: "paintbrush") {
          Text(LocalizedStrings.Settings.appearanceThemePickerTitle.localized)
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
          Picker("", selection: $viewModel.appTheme) {
            ForEach(AppTheme.allCases) { theme in
              Text(theme.title).tag(theme)
            }
          }
          .pickerStyle(.segmented)
        }
        
        SettingsSection(title: LocalizedStrings.Settings.learningTitle.localized, icon: "eye.slash") {
          Text(LocalizedStrings.Settings.learningHiddenSidePickerTitle.localized)
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
          Picker("", selection: $viewModel.hiddenSide) {
            ForEach(HiddenSide.allCases) { side in
              Text(side.title).tag(side)
            }
          }
          .pickerStyle(.segmented)
          Text(LocalizedStrings.Settings.learningDescription.localized)
            .font(.footnote)
            .foregroundStyle(.secondary)
          Text(LocalizedStrings.Settings.learningRepeatingIntervalPickerTitle.localized)
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
          Picker("", selection: $viewModel.repeatingPeriod) {
            ForEach(RepeatingPeriod.allCases) { period in
              Text(period.title).tag(period)
            }
          }
          .pickerStyle(.segmented)
          Text(LocalizedStrings.Settings.learningRepeatingDescription.localized)
            .font(.footnote)
            .foregroundStyle(.secondary)
        }
        Spacer()
      }
      .padding()
    }
    .navigationTitle(LocalizedStrings.Settings.title.localized)
    .background {
      environment.styleService.commonBackgroundGradient
        .ignoresSafeArea()
    }
  }
}
