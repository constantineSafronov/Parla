//
//  SetListView.swift
//  Parla
//
//  Created by Konstantin Safronov on 19.12.2025.
//

import SwiftUI
import SwiftData
import Observation

struct SetListView: View {
  
  @Bindable private var viewModel: SetListViewModel
  
  init(viewModel: SetListViewModel) {
    self.viewModel = viewModel
    viewModel.takeOff()
  }
  
  var body: some View {
    ScrollView {
      LazyVGrid(columns: viewModel.gridColumns, spacing: 16) {
        ForEach(viewModel.items) { wordSet in
          SetCard(set: wordSet)
            .onTapGesture {
              viewModel.navigateToWordList(wordSet)
            }
            .contextMenu {
              Button(role: .destructive) {
                viewModel.confirmDelete(wordSet)
              } label: {
                Label(
                  LocalizedStrings.Common.delete.localized,
                  systemImage: "trash"
                )
              }
            }
        }
      }
      .padding()
    }
    .background {
      viewModel.backgroundGradient
        .ignoresSafeArea()
    }
    .confirmationDialog(
      viewModel.deleteConfirmationTitle,
      isPresented: $viewModel.showDeleteConfirmation,
      presenting: viewModel.setToDelete
    ) { set in
      Button(LocalizedStrings.Common.delete.localized, role: .destructive) {
        viewModel.deleteSet(set)
      }
      Button(LocalizedStrings.Common.cancel.localized, role: .cancel) {
        viewModel.cancelDelete()
      }
    } message: { set in
      Text(String(
        format: LocalizedStrings.Common.deleteConfirmationDialog.localized,
        set.title
      ))
    }
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button {
          viewModel.presentCreateWordSet()
        } label: {
          Image(systemName: "plus")
        }
      }
    }
  }
}
