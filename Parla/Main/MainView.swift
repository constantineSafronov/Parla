//
//  MainView.swift
//  Parla
//
//  Created by Konstantin Safronov on 20.12.2025.
//

import SwiftUI
import SwiftData

struct MainView: View {
  
  // MARK: - Properties
  
  @AppStorage(AppSettingsKey.appTheme) private var appTheme: AppTheme = .system
  @Environment(\.modelContext) private var modelContext
  @State private var coordinator = AppCoordinator()
  @State private var styleService = StyleService()
  
  // MARK: - Body
  
  var body: some View {
    TabView {
      NavigationStack(path: $coordinator.path) {
        SetList()
          .navigationDestination(for: Destination.self) { destination in
            switch destination {
            case .wordList(let set):
              WordList(model: WordListViewModel(wordSet: set, modelContext: modelContext))
                .toolbar(.hidden, for: .tabBar)
              
            case .createWordSet:
              EmptyView()
            case .createWord:
              EmptyView()
            }
          }
      }
      .tabItem {
        Label(LocalizedStrings.TabBar.setList.localized, systemImage: "square.stack.3d.up")
      }
      .environment(coordinator)
      .sheet(isPresented: $coordinator.showCreateSetSheet) {
        CreateWordSet { set in
          modelContext.insert(set)
          coordinator.dismissCreateSetSheet()
        }
        .presentationBackground(styleService.commonBackgroundGradient)
      }
      
      LearningView(viewModel: LearningViewModel(synthesizer: SpeechSynthesizer()))
        .tabItem {
          Label(LocalizedStrings.TabBar.learning.localized, systemImage: "rectangle.stack")
        }
        .environment(coordinator)
      SettingsList()
        .tabItem {
          Label(LocalizedStrings.TabBar.settings.localized, systemImage: "gearshape")
        }
        .environment(coordinator)
    }
    .preferredColorScheme(appTheme.colorScheme)
    .environment(styleService)
  }
}
