//
//  WordList.swift
//  Parla
//
//  Created by Konstantin Safronov on 21.12.2025.
//

import SwiftUI

struct WordList: View {
  
  @Environment(StyleService.self) private var styleService
  @Environment(AppCoordinator.self) private var coordinator
  
  @State private var showDeleteConfirmation = false
  @State private var showAddWord = false
  
  let model: WordListViewModel
  
  init(model: WordListViewModel) {
    self.model = model
  }
  
  var body: some View {
    List {
      ForEach(model.set.words) { word in
        WordView(set: word)
          .listRowBackground(Color.clear)
          .listRowSeparator(.hidden)
          .contextMenu {
            Button(role: .destructive) {
              model.wordToDelete = word
              showDeleteConfirmation = true
            } label: {
              Label(LocalizedStrings.Common.delete.localized, systemImage: "trash")
            }
          }
      }
    }
    .listStyle(.plain)
    .background {
      styleService.commonBackgroundGradient
      .ignoresSafeArea()
    }
    .confirmationDialog(
      LocalizedStrings.WordList.deleteConfirmationDialogTitle.localized,
      isPresented: $showDeleteConfirmation,
      presenting: model.wordToDelete
    ) { word in
      Button(LocalizedStrings.Common.delete.localized, role: .destructive) {
        withAnimation {
          model.deleteWord(word: word)
        }
      }
      Button(LocalizedStrings.Common.cancel.localized, role: .cancel) { }
    } message: { word in
      Text(String(format: LocalizedStrings.Common.deleteConfirmationDialog.localized, word.value))
    }
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button {
          showAddWord = true
        } label: {
          Image(systemName: "plus")
        }
      }
    }
    .sheet(isPresented: $showAddWord) {
      CreateWord(viewModel: CreateWordViewModel(repository: DictionaryService())) { value, translation in
        model.addWord(value: value, translation: translation)
      }
      .presentationBackground(styleService.commonBackgroundGradient)
    }
  }
}

//#Preview {
//  WordList(set: WordSet(title: "Test", subtitle: "Test", emoji: "Test"))
//    .modelContainer(for: Word.self, inMemory: true)
//}
