//
//  AppCoordinator.swift
//  Parla
//
//  Created by Konstantin Safronov on 21.12.2025.
//

import SwiftUI
import Observation

enum Destination: Hashable {
  case wordList(WordSet)
  case createWordSet
  case createWord
}

@MainActor
@Observable
final class AppCoordinator {

  var path = NavigationPath()
  var showCreateSetSheet = false
  var showCreateWordSheet = false
  
  // MARK: - Navigation
  
  func push(_ destination: Destination) {
    path.append(destination)
  }
  
  func pop() {
    path.removeLast()
  }
  
  func popToRoot() {
    path.removeLast(path.count)
  }
  
  // MARK: - Sheets
  
  func presentCreateWordSet() {
    showCreateSetSheet = true
  }
  
  func presentCreateWord() {
    showCreateWordSheet = true
  }
  
  func dismissCreateSetSheet() {
    showCreateSetSheet = false
  }
  
  func dismissCreateWordSheet() {
    showCreateWordSheet = false
  }
}
