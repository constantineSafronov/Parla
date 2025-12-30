//
//  WordList.swift
//  Parla
//
//  Created by Konstantin Safronov on 21.12.2025.
//

import SwiftUI
import SwiftData
import Observation

struct WordList: View {
  
  @Bindable var viewModel: WordListViewModel
  
  init(viewModel: WordListViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    List {
      ForEach(viewModel.set.words) { word in
        WordView(word: word)
          .listRowBackground(Color.clear)
          .listRowSeparator(.hidden)
          .contextMenu {
            Button(role: .destructive) {
              viewModel.wordToDelete = word
              viewModel.showDeleteConfirmation = true
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
      viewModel.environment.styleService.commonBackgroundGradient
        .ignoresSafeArea()
    }
    .confirmationDialog(
      LocalizedStrings.WordList.deleteConfirmationDialogTitle.localized,
      isPresented: $viewModel.showDeleteConfirmation,
      presenting: viewModel.wordToDelete
    ) { word in
      Button(
        LocalizedStrings.Common.delete.localized,
        role: .destructive
      ) {
        withAnimation {
          viewModel.deleteWord(word: word)
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
          viewModel.presentCreateWord()
        } label: {
          Image(systemName: "plus")
        }
      }
    }
  }
}

#Preview {
  WordList(
    viewModel: WordListViewModel(
      wordSet: WordSet(title: "Test", subtitle: "Test", emoji: "Test"),
      modelContext: MockModelContext(),
      coordinator: AppCoordinator(),
      environment: AppEnvironment(styleService: StyleService(), dictionaryService: DictionaryService())
    )
  )
}
