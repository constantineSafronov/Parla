//
//  SuggestedWordList.swift
//  Parla
//
//  Created by Konstantin Safronov on 26.12.2025.
//

import SwiftUI

struct SuggestedWordList: View {
  
  private var suggestedWords: [(String, String)]
  
  let suggestionWasTapped: (((String, String)) -> Void)
  
  init(suggestedWords: [(String, String)], suggestionWasTapped: @escaping (((String, String)) -> Void)) {
    self.suggestedWords = suggestedWords
    self.suggestionWasTapped = suggestionWasTapped
  }
  
  var body: some View {
    ScrollView {
      SuggestionsFlowLayout(items: suggestedWords.map { word in
        AnyView(SuggestedWordView(suggestedWord: word)
          .onTapGesture {
            suggestionWasTapped(word)
          })
      }, spacing: 8)
      .padding()
    }
  }
}
