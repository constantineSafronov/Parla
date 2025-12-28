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
  let wordService: WordServiceProtocol
  let repeatingPeriod: RepeatingPeriod
  private let shuffle: ([Word]) -> [Word]
  
  init(
    shuffle: @escaping ([Word]) -> [Word] = { $0.shuffled() },
    synthesizer: SpeechSynthesizerProtocol,
    wordService: WordServiceProtocol,
    repeatingPeriod: RepeatingPeriod
  ) {
    self.shuffle = shuffle
    self.synthesizer = synthesizer
    self.wordService = wordService
    self.repeatingPeriod = repeatingPeriod
  }
  
  var words: [Word] = []
  
  // Testing Property
  var results: [Word.ID: SwipeResult] = [:]
  
  var currentWord: Word? {
    words.first
  }
  
  var isFinished: Bool {
    words.isEmpty
  }
  
  func load(from set: WordSet) {
    words = wordService.updatedWordsAccordingToRepeatingPeriod(
      words: set.words,
      repeatingPeriod: repeatingPeriod
    ).filter { !$0.isLearned }
    words = shuffle(words)
    results.removeAll()
  }
  
  func register(_ word: Word, result: SwipeResult) {
    results[word.id] = result
    
    switch result {
    case.known:
      word.trackCorrectAnswer()
    case .unknown:
      word.trackWrongAnswer()
    }
    words.removeFirst()
  }
  
  func performVoiceOver(word: String) {
    speakItalian(word)
  }
  
  func speakItalian(_ text: String) {
    synthesizer.speak(text, language: "it-IT")
  }
}
