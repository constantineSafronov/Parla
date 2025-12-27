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
  var wordToDelete: Word?
  
  init(wordSet: WordSet, modelContext: ModelContextProtocol) {
    self.set = wordSet
    self.modelContext = modelContext
  }
  
  convenience init(wordSet: WordSet) {
    self.init(wordSet: wordSet, modelContext: MockModelContext())
  }
  
  func deleteWord(word: Word) {
    modelContext.delete(word)
  }
  
  func addWord(value: String, translation: String) {
    modelContext.insert(Word(value: value, translation: translation, set: set))
  }
}
