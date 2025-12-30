//
//  LearningView.swift
//  Parla
//
//  Created by Konstantin Safronov on 22.12.2025.
//

import SwiftUI
import SwiftData

struct LearningView: View {
    
  @State private var viewModel: LearningViewModel
  
  // MARK: - Body
  
  init(viewModel: LearningViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack(spacing: 24) {
      wordSetPicker
      Spacer()
      ZStack {
        if viewModel.words.isEmpty {
          finishedView
        } else {
          CardStackView(
            words: viewModel.words,
            hiddenSide: viewModel.hiddenSide,
            onSwipe: { word, result in
              viewModel.register(word, result: result)
            }
          ) { text in
            viewModel.performVoiceOver(word: text)
          }
        }
      }
      .frame(height: 320)
      .padding(.bottom, 40)
      
      Spacer()
    }
    .frame(maxWidth: .infinity)
    .background {
      viewModel.environment.styleService.commonBackgroundGradient
      .ignoresSafeArea()
    }
    .navigationTitle(LocalizedStrings.Learning.title.localized)
    .task {
      startWithDefaultSetIfNeeded()
    }
    .onChange(of: viewModel.selectedSet) { _, newSet in
      if let newSet {
        viewModel.load(from: newSet)
      }
    }
    .task {
      await viewModel.loadSets()
    }
  }
  
  // MARK: - Body parts
  
  private var wordSetPicker: some View {
    Picker(LocalizedStrings.Learning.pickerTitle.localized, selection: $viewModel.selectedSet) {
      ForEach(viewModel.sets) { set in
        Text("\(set.emoji) \(set.title)")
          .tag(Optional(set))
      }
    }
    .pickerStyle(.menu)
  }
  
  private var finishedView: some View {
    VStack(spacing: 12) {
      if let set = viewModel.selectedSet {
        Text(LocalizedStrings.Learning.finishedViewTitle.localized)
          .font(.headline)
        
        Button(LocalizedStrings.Learning.finishedViewStartTitle.localized) {
          viewModel.load(from: set)
        }
        .buttonStyle(.glass)
      } else {
        Text(LocalizedStrings.Learning.emptyStateText.localized)
          .foregroundStyle(.secondary)
      }
    }
  }
  
  private func startWithDefaultSetIfNeeded() {
    guard viewModel.selectedSet == nil else { return }
    
    viewModel.selectedSet = viewModel.sets.first
    
    if let first = viewModel.sets.first {
      viewModel.load(from: first)
    }
  }
}
