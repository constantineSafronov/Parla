//
//  MainView.swift
//  Parla
//
//  Created by Konstantin Safronov on 20.12.2025.
//

import SwiftUI
import SwiftData
import Observation

// MARK: - MainView

struct MainView: View {
  
  @AppStorage(AppSettingsKey.appTheme)
  private var appTheme: AppTheme = .system
  
  @AppStorage(AppSettingsKey.repeatingPeriod)
  private var repeatingPeriod: RepeatingPeriod = .never
  
  @State private var coordinator = AppCoordinator()
  
  @Environment(\.modelContext) private var modelContext
  @Environment(\.appEnvironment) private var environment
  
  var body: some View {
    TabView {
      setListTab
      learningViewTab
      settingsTab
    }
    .preferredColorScheme(appTheme.colorScheme)
    .environment(coordinator)
  }
}

extension MainView {
  var setListTab: some View {
    SetFlowNavigationHost(modelContext: modelContext)
      .tabItem {
        Label(
          LocalizedStrings.TabBar.setList.localized,
          systemImage: "square.stack.3d.up"
        )
      }
  }
  
  var learningViewTab: some View {
    LearningView(
      viewModel: LearningViewModel(
        synthesizer: SpeechSynthesizer(),
        wordService: WordService(),
        repeatingPeriod: repeatingPeriod,
        environment: environment,
        modelContext: modelContext
      )
    )
    .tabItem {
      Label(
        LocalizedStrings.TabBar.learning.localized,
        systemImage: "rectangle.stack"
      )
    }
  }
  
  var settingsTab: some View {
    SettingsList(viewModel: SettingsListViewModel(environment: environment))
      .tabItem {
        Label(
          LocalizedStrings.TabBar.settings.localized,
          systemImage: "gearshape"
        )
      }
  }
}
