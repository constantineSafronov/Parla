//
//  WordSet.swift
//  Parla
//
//  Created by Konstantin Safronov on 19.12.2025.
//

import Foundation
import SwiftData

@Model
final class WordSet {
  @Attribute(.unique) var id = UUID()
  var title: String
  var subtitle: String
  var emoji: String
  var createdAt = Date()
  var words: [Word] = []
  
  init(title: String, subtitle: String, emoji: String) {
    self.title = title
    self.subtitle = subtitle
    self.emoji = emoji
  }
}

extension WordSet {
  static func mock(words: [Word] = [Word.mock(), Word.mock()]) -> WordSet {
    let set = WordSet(title: "Mock Set", subtitle: "Subtitle", emoji: "📝")
    set.words = words
    
    return set
  }
}

extension WordSet {
  func toDTO() -> WordSetDTO {
    WordSetDTO(
      id: id,
      title: title,
      emoji: emoji
    )
  }
}
