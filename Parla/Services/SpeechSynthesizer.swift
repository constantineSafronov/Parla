//
//  SpeechSynthesizer.swift
//  Parla
//
//  Created by Konstantin Safronov on 28.12.2025.
//

import AVFoundation

protocol SpeechSynthesizerProtocol {
  func speak(_ text: String, language: String)
}

extension SpeechSynthesizer: SpeechSynthesizerProtocol {}
extension MockSpeechSynthesizer: SpeechSynthesizerProtocol {}

class MockSpeechSynthesizer {
  var text = ""
  var language = ""
  func speak(_ text: String, language: String) {
    self.text = text
    self.language = language
  }
}

class SpeechSynthesizer {
  let synthesizer = AVSpeechSynthesizer()
  
  func speak(_ text: String, language: String) {
    let utterance = AVSpeechUtterance(string: text)
    utterance.voice = AVSpeechSynthesisVoice(language: language)
    utterance.rate = AVSpeechUtteranceDefaultSpeechRate
    utterance.pitchMultiplier = 1.0
    utterance.volume = 1.0
    
    synthesizer.speak(utterance)
  }
}
