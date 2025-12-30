//
//  ParlaApp.swift
//  Parla
//
//  Created by Konstantin Safronov on 19.12.2025.
//

import SwiftUI
import SwiftData

@main
struct ParlaApp: App {
  
  @State private var styleService = StyleService()
  
  init() {
    _ = WatchSyncService.shared
  }
  
  var sharedModelContainer: ModelContainer = {
    let schema = Schema([
      WordSet.self,
      Word.self
    ])
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
    
    do {
      return try ModelContainer(for: schema, configurations: [modelConfiguration])
    } catch {
      fatalError("Could not create ModelContainer: \(error)")
    }
  }()
  
  var body: some Scene {
    WindowGroup {
      MainView()
        .environment(
          \.appEnvironment,
           AppEnvironment(
            styleService: styleService,
            dictionaryService: DictionaryService()
           )
        )
    }
    .modelContainer(sharedModelContainer)
  }
}
