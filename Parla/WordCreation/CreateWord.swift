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
  
  @State private var value = ""
  @State private var translation = ""
  
  var onCreate: (String, String) -> Void
  
  var body: some View {
    NavigationStack {
      VStack(spacing: 24) {
        TextField(LocalizedStrings.CreateWord.word.localized, text: $value)
          .font(.title2)
        TextField(LocalizedStrings.CreateWord.translation.localized, text: $translation, axis: .vertical)
          .foregroundStyle(.secondary)
        
        Spacer()
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
            onCreate(value, translation)
            dismiss()
          }
          .disabled(value.isEmpty)
        }
      }
    }
  }
}
