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
  
  private let shuffle: ([Word]) -> [Word]
  private let modelContext: ModelContextProtocol
  
  let synthesizer: SpeechSynthesizerProtocol
  let wordService: WordServiceProtocol
  let repeatingPeriod: RepeatingPeriod
  let environment: AppEnvironment
  
  var sets: [WordSet] = []
  var selectedSet: WordSet?
  var hiddenSide: HiddenSide {
    didSet { UserDefaults.standard.set(hiddenSide.rawValue, forKey: AppSettingsKey.hiddenSide) }
  }
  
  init(
    shuffle: @escaping ([Word]) -> [Word] = { $0.shuffled() },
    synthesizer: SpeechSynthesizerProtocol,
    wordService: WordServiceProtocol,
    repeatingPeriod: RepeatingPeriod,
    environment: AppEnvironment,
    modelContext: ModelContextProtocol
  ) {
    self.shuffle = shuffle
    self.synthesizer = synthesizer
    self.wordService = wordService
    self.repeatingPeriod = repeatingPeriod
    self.environment = environment
    self.modelContext = modelContext
    
    let rawSide = UserDefaults.standard.string(forKey: AppSettingsKey.hiddenSide) ?? ""
    self.hiddenSide = HiddenSide(rawValue: rawSide) ?? .translation
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
  
  @MainActor
  func loadSets() async {
    let descriptor = FetchDescriptor<WordSet>(
      sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
    )
    do {
      sets = try modelContext.fetch(descriptor)
    } catch {
      sets = []
    }
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
