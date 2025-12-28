//
//  ParlaTests.swift
//  ParlaTests
//
//  Created by Konstantin Safronov on 19.12.2025.
//

import XCTest
import SwiftData
@testable import Parla

@MainActor
final class ParlaTests: XCTestCase {
  
  func testLoadResetsState() async {
    let words = [Word.mock(), Word.mock()]
    let set = WordSet.mock(words: words)
    let vm = LearningViewModel(shuffle: { $0 }, synthesizer: MockSpeechSynthesizer())
    vm.load(from: set)
    
    XCTAssertEqual(vm.words.count, 2)
    XCTAssertTrue(vm.results.isEmpty)
    XCTAssertEqual(vm.currentWord?.id, words.first?.id)
  }
  
  func testRegisterRemovesCurrentWord() async {
    let word1 = Word.mock()
    let word2 = Word.mock()
    
    let vm = LearningViewModel(
      shuffle: { $0 },
      synthesizer: MockSpeechSynthesizer()
    )
    vm.load(from: .mock(words: [word1, word2]))
    
    vm.register(word1, result: .known)
    
    XCTAssertEqual(vm.results[word1.id], .known)
    XCTAssertEqual(vm.currentWord?.id, word2.id)
  }
  
  func testIsFinishedWhenNoWordsLeft() async {
    let word = Word.mock()
    
    let vm = LearningViewModel(
      shuffle: { $0 },
      synthesizer: MockSpeechSynthesizer()
    )
    vm.load(from: .mock(words: [word]))
    
    vm.register(word, result: .known)
    
    XCTAssertTrue(vm.isFinished)
  }
}
