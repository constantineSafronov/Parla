//
//  WatchSyncService.swift
//  Parla
//
//  Created by Konstantin Safronov on 30.12.2025.
//

import WatchConnectivity

@MainActor
final class WatchSyncService: NSObject, WCSessionDelegate {
  
  static let shared = WatchSyncService()
  
  override init() {
    super.init()
    if WCSession.isSupported() {
      WCSession.default.delegate = self
      WCSession.default.activate()
    }
  }
  
  func sendSets(_ sets: [WordSetDTO], words: [WordDTO]) {
    guard WCSession.default.isReachable else { return }
    
    let payload: [String: Any] = [
      "sets": try! JSONEncoder().encode(sets),
      "words": try! JSONEncoder().encode(words)
    ]
    
    WCSession.default.sendMessage(payload, replyHandler: nil)
  }
  
  func session(_: WCSession, activationDidCompleteWith _: WCSessionActivationState, error _: Error?) {}
  
  func sessionDidBecomeInactive(_ session: WCSession) {}
  
  func sessionDidDeactivate(_ session: WCSession) {
      WCSession.default.activate()
  }
}
