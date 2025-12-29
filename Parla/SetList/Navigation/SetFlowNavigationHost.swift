//
//  SetFlowNavigationHost.swift
//  Parla
//
//  Created by Konstantin Safronov on 29.12.2025.
//

import SwiftUI
import SwiftData

// MARK: - Sheets

enum AppSheet: Identifiable {
  case createWordSet
  case createWord
  
  var id: String {
    switch self {
    case .createWordSet: return "createWordSet"
    case .createWord: return "createWord"
    }
  }
}

// MARK: - Flow Context

enum AppFlowContext {
  case wordSet(WordSet)
}

struct SetFlowNavigationHost: View {
  
  let modelContext: ModelContext
  
  @Environment(AppCoordinator.self) private var coordinator
  @Environment(\.appEnvironment) private var environment
  
  var body: some View {
    NavigationStack(path: Bindable(coordinator).path) {
      SetList()
        .navigationDestination(
          for: AppRoute.SetList.self,
          destination: routeView
        )
    }
    .sheet(item: Bindable(coordinator).sheet) { sheet in
      sheetView(sheet)
    }
  }
  
  // MARK: Routes
  
  @ViewBuilder
  private func routeView(_ route: AppRoute.SetList) -> some View {
    switch route {
    case .wordList(let set):
      WordList(
        model: WordListViewModel(
          wordSet: set,
          modelContext: modelContext
        )
      )
      .toolbar(.hidden, for: .tabBar)
    }
  }
  
  // MARK: Sheets
  
  @ViewBuilder
  private func sheetView(_ sheet: AppSheet) -> some View {
    switch sheet {
      
    case .createWordSet:
      CreateWordSet { set in
        modelContext.insert(set)
        coordinator.dismissSheet()
      }
      .presentationBackground(
        environment.styleService.commonBackgroundGradient
      )
      
    case .createWord:
      if case let .wordSet(set) = coordinator.flowContext {
        let store = WordStore(
          set: set,
          modelContext: modelContext
        )
        
        CreateWord(
          viewModel: CreateWordViewModel(
            repository: environment.dictionaryService
          )
        ) { value, translation in
          store.addWord(
            value: value,
            translation: translation
          )
          coordinator.dismissSheet()
        }
        .presentationBackground(
          environment.styleService.commonBackgroundGradient
        )
      }
    }
  }
}

extension AppCoordinator {
  // Navigation
  
  func push(_ route: AppRoute.SetList) {
    if case let .wordList(set) = route {
      flowContext = .wordSet(set)
    }
    path.append(route)
  }
  
  // Sheets

  func presentCreateWordSet() {
    sheet = .createWordSet
  }

  func presentCreateWord() {
    sheet = .createWord
  }
}
