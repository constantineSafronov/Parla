//
//  ModelContext.swift
//  Parla
//
//  Created by Konstantin Safronov on 26.12.2025.
//

import SwiftData

protocol ModelContextProtocol {
  func delete<T: PersistentModel>(_ model: T)
  func insert<T: PersistentModel>(_ model: T)
  func fetch<T>(_ descriptor: FetchDescriptor<T>) throws -> [T] where T : PersistentModel
}

extension ModelContext: ModelContextProtocol {}

@MainActor
class MockModelContext: ModelContextProtocol {
  var deletedItems: [Any] = []
  var insertedItems: [Any] = []
  
  func delete<T: PersistentModel>(_ model: T) {
    deletedItems.append(model)
  }
  
  func insert<T: PersistentModel>(_ model: T) {
    insertedItems.append(model)
  }
  
  func fetch<T>(_ descriptor: FetchDescriptor<T>) throws -> [T] where T : PersistentModel {
    return []
  }
}
