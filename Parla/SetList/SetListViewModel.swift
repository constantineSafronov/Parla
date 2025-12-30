//
//  SetListViewModel.swift
//  Parla
//
//  Created by Konstantin Safronov on 30.12.2025.
//

import SwiftUI
import Observation
import SwiftData


@Observable
final class SetListViewModel {
  private let modelContext: ModelContext
  private let coordinator: AppCoordinator
  private let environment: AppEnvironment
  
  var items: [WordSet] = []
  var setToDelete: WordSet?
  var showDeleteConfirmation = false
  var showCreateSet = false
  
  private let columns = [
    GridItem(.flexible(), spacing: 16),
    GridItem(.flexible(), spacing: 16)
  ]
  
  var gridColumns: [GridItem] { columns }
  var backgroundGradient: LinearGradient { environment.styleService.commonBackgroundGradient }
  var deleteConfirmationTitle: String { LocalizedStrings.SetList.deleteConfirmationDialogTitle.localized }
  
  init(
    modelContext: ModelContext,
    coordinator: AppCoordinator,
    environment: AppEnvironment
  ) {
    self.modelContext = modelContext
    self.coordinator = coordinator
    self.environment = environment
  }
  
  func takeOff() {
    loadSets()
    syncWithWatch()
  }
  
  func loadSets() {
    let descriptor = FetchDescriptor<WordSet>(
      sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
    )
    
    do {
      items = try modelContext.fetch(descriptor)
    } catch {
      print("Error fetching sets: \(error)")
    }
  }
  
  func deleteSet(_ set: WordSet) {
    withAnimation {
      modelContext.delete(set)
      items.removeAll { $0.id == set.id }
    }
  }
  
  func navigateToWordList(_ set: WordSet) {
    coordinator.push(.wordList(set))
  }
  
  func presentCreateWordSet() {
    coordinator.presentCreateWordSet()
  }
  
  func confirmDelete(_ set: WordSet) {
    setToDelete = set
    showDeleteConfirmation = true
  }
  
  func cancelDelete() {
    setToDelete = nil
    showDeleteConfirmation = false
  }
  
  private func syncWithWatch() {
    WatchSyncService.shared.sendSets(
      items.map { $0.toDTO() },
      words: items.flatMap { $0.words }.map { $0.toDTO() }
    )
  }
}
