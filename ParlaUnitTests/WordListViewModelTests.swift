//
//  WordListModelTests.swift
//  Parla
//
//  Created by Konstantin Safronov on 23.12.2025.
//

import Testing
import SwiftData
@testable import Parla

@Test("Word deletion")
func testDeleteWord() {
  let mockContext = MockModelContext()
  let wordSet = WordSet.mock()
  let model = WordListViewModel(wordSet: wordSet, modelContext: mockContext)
  let wordToDelete = Word.mock()
  
  model.deleteWord(word: wordToDelete)
  
  #expect(mockContext.deletedItems.count == 1)
  #expect(mockContext.deletedItems.first as? Word === wordToDelete)
}

@Test("Word creation")
func testAddWord() {
  let mockContext = MockModelContext()
  let wordSet = WordSet.mock()
  let model = WordListViewModel(wordSet: wordSet)
  
  model.addWord(value: "Hello", translation: "Hello")
  #expect(mockContext.insertedItems.count == 1)
}
