//
//  WatchMainView.swift
//  Parla
//
//  Created by Konstantin Safronov on 30.12.2025.
//

import SwiftUI
import WatchConnectivity

struct WatchMainView: View {
  @Bindable private var store = WatchDataStore.shared
  
  var body: some View {
    NavigationStack {
      List(store.sets) { set in
        NavigationLink {
          WatchCardLearningView()
        } label: {
          Text("\(set.emoji) \(set.title)")
        }
      }
    }
    .background {
      LinearGradient(
        colors: [Color.blue.opacity(0.4), Color.purple.opacity(0.4)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
      )
        .ignoresSafeArea()
    }
  }
}
