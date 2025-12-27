//
//  DictionaryWord.swift
//  Parla
//
//  Created by Konstantin Safronov on 26.12.2025.
//

import Foundation

struct DictionaryWord: Decodable {
  
  let word: String
  let translation: [String]
  
  private enum CodingKeys: String, CodingKey {
    case word = "italian"
    case translation = "russian"
  }
  
  var suggestion: (String, String) {
    return (word, translation.last ?? "")
  }
}
