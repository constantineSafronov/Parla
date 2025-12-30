//
//  WatchDataStore.swift
//  Parla
//
//  Created by Konstantin Safronov on 30.12.2025.
//

import WatchConnectivity
import Combine

@MainActor
@Observable
final class WatchDataStore: NSObject, WCSessionDelegate {
  static let shared = WatchDataStore()
  
  var currentIndex = 0
  var sets: [WordSetDTO] = []
  var words: [WordDTO] = []
  
  var currentWord: WordDTO? {
    guard currentIndex < words.count else { return nil }
    return words[currentIndex]
  }
  
  override init() {
    super.init()
    
    if WCSession.isSupported() {
      let session = WCSession.default
      session.delegate = self

      session.activate()
    }
  }
  
  func markKnown() {
    currentIndex += 1
  }
  
  func markUnknown() {
    currentIndex += 1
  }
  
  func session(_ session: WCSession,
               activationDidCompleteWith activationState: WCSessionActivationState,
               error: Error?) {}
  
  func session(
    _ session: WCSession,
    didReceiveMessage message: [String : Any]
  ) {
    if let setsData = message["sets"] as? Data {
      sets = try! JSONDecoder().decode([WordSetDTO].self, from: setsData)
    }
    if let wordsData = message["words"] as? Data {
      words = try! JSONDecoder().decode([WordDTO].self, from: wordsData)
    }
  }
}
