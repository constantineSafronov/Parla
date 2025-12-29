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
  
  @Environment(\.modelContext)
  private var modelContext
  
  @State private var coordinator = AppCoordinator()
  @State private var styleService = StyleService()
  
  var body: some View {
    TabView {
      setListTab
      learningViewTab
      settingsTab
    }
    .preferredColorScheme(appTheme.colorScheme)
    .environment(coordinator)
    .environment(
      \.appEnvironment,
       AppEnvironment(
        styleService: styleService,
        dictionaryService: DictionaryService()
       )
    )
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
        repeatingPeriod: repeatingPeriod
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
    SettingsList(viewModel: SettingsListViewModel())
      .tabItem {
        Label(
          LocalizedStrings.TabBar.settings.localized,
          systemImage: "gearshape"
        )
      }
  }
}
