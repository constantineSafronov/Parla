//
//  WordListViewModel.swift
//  Parla
//
//  Created by Konstantin Safronov on 23.12.2025.
//

import SwiftUI
import SwiftData
import Observation

@Observable
final class WordListViewModel {
  private let modelContext: ModelContextProtocol
  private(set) var set: WordSet
  private let coordinator: AppCoordinator
  let environment: AppEnvironment
  var showDeleteConfirmation = false
  var wordToDelete: Word?
  
  init(
    wordSet: WordSet,
    modelContext: ModelContextProtocol,
    coordinator: AppCoordinator,
    environment: AppEnvironment
  ) {
    self.set = wordSet
    self.modelContext = modelContext
    self.coordinator = coordinator
    self.environment = environment
  }
  
  func deleteWord(word: Word) {
    modelContext.delete(word)
  }
  
  func addWord(value: String, translation: String) {
    modelContext.insert(Word(value: value, translation: translation, set: set))
  }
  
  func presentCreateWord() {
    coordinator.presentCreateWord()
  }
}
