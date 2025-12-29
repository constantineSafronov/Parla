//
//  AppCoordinator.swift
//  Parla
//
//  Created by Konstantin Safronov on 21.12.2025.
//

import SwiftUI
import Observation

// MARK: - Routes

enum AppRoute: Hashable {
  enum SetList: Hashable {
    case wordList(WordSet)
  }
}

@MainActor
@Observable
final class AppCoordinator {

  var path = NavigationPath()
  var sheet: AppSheet?
  var flowContext: AppFlowContext?

  func pop() {
    path.removeLast()
  }

  func popToRoot() {
    path.removeLast(path.count)
    flowContext = nil
  }

  func dismissSheet() {
    sheet = nil
  }
}
