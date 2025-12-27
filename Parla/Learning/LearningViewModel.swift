//
//  LearningViewModel.swift
//  Parla
//
//  Created by Konstantin Safronov on 22.12.2025.
//

import Observation
import SwiftData
import SwiftUI
import AVFoundation

enum SwipeResult {
  case known
  case unknown
}

@MainActor
@Observable
final class LearningViewModel {
  
  let synthesizer = AVSpeechSynthesizer()
  private let shuffle: ([Word]) -> [Word]
  
  init(shuffle: @escaping ([Word]) -> [Word] = { $0.shuffled() }) {
    self.shuffle = shuffle
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
    let utterance = AVSpeechUtterance(string: text)
    utterance.voice = AVSpeechSynthesisVoice(language: "it-IT")
    utterance.rate = AVSpeechUtteranceDefaultSpeechRate
    utterance.pitchMultiplier = 1.0
    utterance.volume = 1.0
    
    synthesizer.speak(utterance)
  }
}
