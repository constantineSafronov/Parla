//
//  LearningView.swift
//  Parla
//
//  Created by Konstantin Safronov on 22.12.2025.
//

import SwiftUI
import SwiftData

struct LearningView: View {
  
  // MARK: - State
  
  @Environment(StyleService.self) private var styleService
  @State private var selectedSet: WordSet?
  @State private var viewModel: LearningViewModel
  @Query private var sets: [WordSet]
  
  @AppStorage(AppSettingsKey.hiddenSide) private var hiddenSide: HiddenSide = .word
  
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
            hiddenSide: hiddenSide,
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
      styleService.commonBackgroundGradient
      .ignoresSafeArea()
    }
    .navigationTitle(LocalizedStrings.Learning.title.localized)
    .task {
      startWithDefaultSetIfNeeded()
    }
    .onChange(of: selectedSet) { _, newSet in
      if let newSet {
        viewModel.load(from: newSet)
      }
    }
  }
  
  // MARK: - Body parts
  
  private var wordSetPicker: some View {
    Picker(LocalizedStrings.Learning.pickerTitle.localized, selection: $selectedSet) {
      ForEach(sets) { set in
        Text("\(set.emoji) \(set.title)")
          .tag(Optional(set))
      }
    }
    .pickerStyle(.menu)
  }
  
  private var finishedView: some View {
    VStack(spacing: 12) {
      if let set = selectedSet {
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
    guard selectedSet == nil else { return }
    
    selectedSet = sets.first
    
    if let first = sets.first {
      viewModel.load(from: first)
    }
  }
}
