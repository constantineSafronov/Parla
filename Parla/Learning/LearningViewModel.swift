//
//  LearningViewModel.swift
//  Parla
//
//  Created by Konstantin Safronov on 22.12.2025.
//

import Observation
import SwiftData
import SwiftUI

enum SwipeResult {
  case known
  case unknown
}

@MainActor
@Observable
final class LearningViewModel {
  
  let synthesizer: SpeechSynthesizerProtocol
  private let shuffle: ([Word]) -> [Word]
  
  init(
    shuffle: @escaping ([Word]) -> [Word] = { $0.shuffled() },
    synthesizer: SpeechSynthesizerProtocol
  ) {
    self.shuffle = shuffle
    self.synthesizer = synthesizer
  }
  
  var words: [Word] = []
  var results: [Word.ID: SwipeResult] = [:]
  
  var currentWord: Word? {
    words.first
  }
  
  var isFinished: Bool {
    words.isEmpty
  }
  
  func load(from set: WordSet) {
    words = shuffle(set.words)
    results.removeAll()
  }
  
  func register(_ word: Word, result: SwipeResult) {
    results[word.id] = result
    words.removeFirst()
  }
  
  func performVoiceOver(word: String) {
    speakItalian(word)
  }
  
  func speakItalian(_ text: String) {
    synthesizer.speak(text, language: "it-IT")
  }
}
