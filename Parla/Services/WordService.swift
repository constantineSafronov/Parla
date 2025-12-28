//
//  WordService.swift
//  Parla
//
//  Created by Konstantin Safronov on 28.12.2025.
//

import Foundation

protocol WordServiceProtocol {
  func updatedWordsAccordingToRepeatingPeriod(words: [Word], repeatingPeriod: RepeatingPeriod) -> [Word]
}

extension WordService: WordServiceProtocol {}

class WordService {
  func updatedWordsAccordingToRepeatingPeriod(words: [Word], repeatingPeriod: RepeatingPeriod) -> [Word] {
    for word in words {
      if word.learnedAt.monthsUntil() >= repeatingPeriod.policyTerm {
        word.dropRightAnswersNumber()
      }
    }
    return words
  }
}
