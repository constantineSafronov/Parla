//
//  SetList.swift
//  Parla
//
//  Created by Konstantin Safronov on 19.12.2025.
//

import SwiftUI
import SwiftData

struct SetList: View {
  
  @Environment(\.appEnvironment) private var environment
  @Environment(AppCoordinator.self) private var coordinator
  @Environment(\.modelContext) private var modelContext
  @Query(sort: [
    SortDescriptor(\WordSet.createdAt, order: .reverse)
  ])
  private var items: [WordSet]
  @State private var setToDelete: WordSet?
  @State private var showDeleteConfirmation = false
  @State private var showCreateSet = false
  
  private let columns = [
    GridItem(.flexible(), spacing: 16),
    GridItem(.flexible(), spacing: 16)
  ]
  
  var body: some View {
    ScrollView {
      LazyVGrid(columns: columns, spacing: 16) {
        ForEach(items) { set in
          SetCard(set: set)
            .onTapGesture {
              coordinator.push(.wordList(set))
            }
            .contextMenu {
              Button(role: .destructive) {
                setToDelete = set
                showDeleteConfirmation = true
              } label: {
                Label(LocalizedStrings.Common.delete.localized, systemImage: "trash")
              }
            }
        }
      }
      .padding()
    }
    .background {
      environment.styleService.commonBackgroundGradient
        .ignoresSafeArea()
    }
    .confirmationDialog(
      LocalizedStrings.SetList.deleteConfirmationDialogTitle.localized,
      isPresented: $showDeleteConfirmation,
      presenting: setToDelete
    ) { set in
      Button(LocalizedStrings.Common.delete.localized, role: .destructive) {
        withAnimation {
          modelContext.delete(set)
        }
      }
      Button(LocalizedStrings.Common.cancel.localized, role: .cancel) { }
    } message: { set in
      Text(String(format: LocalizedStrings.Common.deleteConfirmationDialog.localized, set.title))
    }
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button {
          coordinator.presentCreateWordSet()
        } label: {
          Image(systemName: "plus")
        }
      }
    }
  }
}

#Preview {
  SetList()
    .modelContainer(for: WordSet.self, inMemory: true)
}
