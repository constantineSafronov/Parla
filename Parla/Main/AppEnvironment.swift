//
//  AppEnvironment.swift
//  Parla
//
//  Created by Konstantin Safronov on 29.12.2025.
//

import SwiftUI

struct AppEnvironment {
  let styleService: StyleService
  let dictionaryService: DictionaryService
}

private struct AppEnvironmentKey: EnvironmentKey {
  static let defaultValue = AppEnvironment(
    styleService: StyleService(),
    dictionaryService: DictionaryService()
  )
}

extension EnvironmentValues {
  var appEnvironment: AppEnvironment {
    get { self[AppEnvironmentKey.self] }
    set { self[AppEnvironmentKey.self] = newValue }
  }
}
