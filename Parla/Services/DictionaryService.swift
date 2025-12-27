//
//  DictionaryService.swift
//  Parla
//
//  Created by Konstantin Safronov on 26.12.2025.
//

import Foundation

protocol WordRepository {
  var words: [DictionaryWord] { get }
}

final class DictionaryService: WordRepository {
  
  private let loader: JSONLoading
  
  lazy var words: [DictionaryWord] = {
    getItems()
  }()
  
  init(loader: JSONLoading = JSONLoader()) {
    self.loader = loader
  }
  
  func getItems() -> [DictionaryWord] {
    do {
      return try loader.load("ita_rus")
    } catch {
      return []
    }
  }
}
