//
//  CreateWord.swift
//  Parla
//
//  Created by Konstantin Safronov on 21.12.2025.
//

import SwiftUI
import SwiftData

struct CreateWord: View {
  
  @Environment(\.dismiss) private var dismiss
  @Bindable private var viewModel: CreateWordViewModel
  
  var onCreate: (String, String) -> Void
  
  init(viewModel: CreateWordViewModel, onCreate: @escaping (String, String) -> Void) {
    self.viewModel = viewModel
    self.onCreate = onCreate
  }
  
  var body: some View {
    NavigationStack {
      VStack(spacing: 24) {
        TextField(LocalizedStrings.CreateWord.word.localized, text: $viewModel.word)
          .font(.title2)
        TextField(LocalizedStrings.CreateWord.translation.localized, text: $viewModel.translation, axis: .vertical)
          .foregroundStyle(.secondary)
        SuggestedWordList(
          suggestedWords: viewModel.suggestedWords
        ) { word in
          viewModel.suggestionSelected(word: word)
          }
      }
      .padding(.top, 44)
      .padding()
      .navigationTitle(LocalizedStrings.CreateWord.title.localized)
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button(LocalizedStrings.Common.cancel.localized) {
            dismiss()
          }
        }
        
        ToolbarItem(placement: .confirmationAction) {
          Button(LocalizedStrings.Common.create.localized) {
            onCreate(viewModel.word, viewModel.translation)
            dismiss()
          }
          .disabled(viewModel.word.isEmpty)
        }
      }
    }
  }
}
