//
//  Word.swift
//  Parla
//
//  Created by Konstantin Safronov on 21.12.2025.
//

import Foundation
import SwiftData

@Model
final class Word {
  @Attribute(.unique) var value: String
  var translation: String
  var set: WordSet?
  var createdAt = Date()
  var learnedAt = Date()
  private var rightAnswersNumber = 0
  
  init(value: String, translation: String, set: WordSet?) {
    self.value = value
    self.translation = translation
    self.set = set
  }
}

extension Word {
  var isLearned: Bool {
    rightAnswersNumber >= 5
  }
  
  func trackCorrectAnswer() {
    rightAnswersNumber += 1
    learnedAt = Date()
  }
  
  func trackWrongAnswer() {
    dropRightAnswersNumber()
  }
  
  func dropRightAnswersNumber() {
    rightAnswersNumber = 0
  }
}

extension Word {
  static func mock(id: UUID = UUID()) -> Word {
    Word(value: "\(id)", translation: "text", set: nil)
  }
}
