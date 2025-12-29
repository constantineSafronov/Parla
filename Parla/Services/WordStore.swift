//
//  WordStore.swift
//  Parla
//
//  Created by Konstantin Safronov on 29.12.2025.
//

import SwiftData

@MainActor
final class WordStore {
  
  private let modelContext: ModelContext
  private let set: WordSet
  
  init(set: WordSet, modelContext: ModelContext) {
    self.set = set
    self.modelContext = modelContext
  }
  
  func addWord(value: String, translation: String) {
    let word = Word(value: value, translation: translation, set: set)
    set.words.append(word)
    modelContext.insert(word)
  }
}
