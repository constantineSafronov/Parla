//
//  WordList.swift
//  Parla
//
//  Created by Konstantin Safronov on 21.12.2025.
//

import SwiftUI
import SwiftData

struct WordList: View {
  
  @Environment(StyleService.self) private var styleService
  @Environment(AppCoordinator.self) private var coordinator
  @Environment(\.modelContext) private var modelContext
  var set: WordSet
  @State private var wordToDelete: Word?
  @State private var showDeleteConfirmation = false
  @State private var showAddWord = false
  
  var body: some View {
    List {
      ForEach(set.words) { word in
        WordView(set: word)
          .listRowBackground(Color.clear)
          .listRowSeparator(.hidden)
          .contextMenu {
            Button(role: .destructive) {
              wordToDelete = word
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
      presenting: wordToDelete
    ) { word in
      Button(LocalizedStrings.Common.delete.localized, role: .destructive) {
        withAnimation {
          modelContext.delete(word)
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
      CreateWord { value, translation in
        modelContext.insert(Word(value: value, translation: translation, set: set))
      }
      .presentationBackground(styleService.commonBackgroundGradient)
    }
  }
}

#Preview {
  WordList(set: WordSet(title: "Test", subtitle: "Test", emoji: "Test"))
    .modelContainer(for: Word.self, inMemory: true)
}
