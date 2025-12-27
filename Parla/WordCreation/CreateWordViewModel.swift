//
//  CreateWordViewModel.swift
//  Parla
//
//  Created by Konstantin Safronov on 26.12.2025.
//

import Foundation
import Observation

@Observable
class CreateWordViewModel {
  
  private let repository: WordRepository
  
  var word: String = "" {
    didSet {
      guard !word.isEmpty else {
        suggestedWords = []
        return
      }
      suggestedWords = searchResult(word: word, wordList: repository.words)
    }
  }
  
  var translation: String = "" {
    didSet {
      guard !translation.isEmpty else {
        suggestedWords = []
        return
      }
      suggestedWords = searchResult(translation: translation, wordList: repository.words)
    }
  }
  
  var suggestedWords: [(String, String)] = []
  
  init(repository: WordRepository) {
    self.repository = repository
  }
  
  func searchResult(word: String, wordList: [DictionaryWord]) -> [(String, String)] {
    let searchCriterea = word.replacingOccurrences(of: " ", with: "")
    
    return Array(wordList.filter { $0.word.lowercased().hasPrefix(searchCriterea.lowercased()) }.map { $0.suggestion }.prefix(5))
  }
  
  func searchResult(translation: String, wordList: [DictionaryWord]) -> [(String, String)] {
    let searchCriterea = translation.replacingOccurrences(of: " ", with: "")
    
    return Array(wordList.filter { $0.suggestion.1.lowercased().hasPrefix(searchCriterea.lowercased()) }.map { $0.suggestion }.prefix(5))
  }
  
  func suggestionSelected(word: (String, String)) {
    self.word = word.0.capitalized
    translation = word.1.capitalized
    suggestedWords = []
  }
}
