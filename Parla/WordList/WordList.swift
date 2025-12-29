//
//  WordList.swift
//  Parla
//
//  Created by Konstantin Safronov on 21.12.2025.
//

import SwiftUI
import SwiftData

struct WordList: View {

  @Environment(\.appEnvironment) private var environment
  @Environment(AppCoordinator.self) private var coordinator

  @State private var showDeleteConfirmation = false

  let model: WordListViewModel

  init(model: WordListViewModel) {
    self.model = model
  }

  var body: some View {
    List {
      ForEach(model.set.words) { word in
        WordView(word: word)
          .listRowBackground(Color.clear)
          .listRowSeparator(.hidden)
          .contextMenu {
            Button(role: .destructive) {
              model.wordToDelete = word
              showDeleteConfirmation = true
            } label: {
              Label(
                LocalizedStrings.Common.delete.localized,
                systemImage: "trash"
              )
            }
          }
      }
    }
    .listStyle(.plain)
    .background {
      environment.styleService.commonBackgroundGradient
        .ignoresSafeArea()
    }
    .confirmationDialog(
      LocalizedStrings.WordList.deleteConfirmationDialogTitle.localized,
      isPresented: $showDeleteConfirmation,
      presenting: model.wordToDelete
    ) { word in
      Button(
        LocalizedStrings.Common.delete.localized,
        role: .destructive
      ) {
        withAnimation {
          model.deleteWord(word: word)
        }
      }
      Button(
        LocalizedStrings.Common.cancel.localized,
        role: .cancel
      ) { }
    } message: { word in
      Text(
        String(
          format: LocalizedStrings.Common
            .deleteConfirmationDialog.localized,
          word.value
        )
      )
    }
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button {
          coordinator.presentCreateWord()
        } label: {
          Image(systemName: "plus")
        }
      }
    }
  }
}

#Preview {
  WordList(
    model: WordListViewModel(
      wordSet: WordSet(title: "Test", subtitle: "Test", emoji: "Test"),
      modelContext: MockModelContext())
  )
}
