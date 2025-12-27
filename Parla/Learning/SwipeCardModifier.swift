//
//  SwipeCardModifier.swift
//  Parla
//
//  Created by Konstantin Safronov on 22.12.2025.
//

import SwiftUI

struct SwipeCardModifier: ViewModifier {
  
  let onSwipeLeft: () -> Void
  let onSwipeRight: () -> Void
  
  @State private var offset: CGSize = .zero
  @State private var isSwiped = false
  
  func body(content: Content) -> some View {
    content
      .offset(offset)
      .rotationEffect(.degrees(Double(offset.width / 12)))
      .gesture(
        DragGesture()
          .onChanged { value in
            guard !isSwiped else { return }
            offset = value.translation
          }
          .onEnded { _ in
            let threshold: CGFloat = 120
            
            if offset.width > threshold {
              completeSwipe(to: .right)
            } else if offset.width < -threshold {
              completeSwipe(to: .left)
            } else {
              withAnimation(.spring()) {
                offset = .zero
              }
            }
          }
      )
  }
  
  private func completeSwipe(to direction: SwipeDirection) {
    isSwiped = true
    
    withAnimation(.easeIn(duration: 0.4)) {
      offset = CGSize(
        width: direction == .right ? 600 : -600,
        height: 0
      )
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      switch direction {
      case .left:
        onSwipeLeft()
      case .right:
        onSwipeRight()
      }
      offset = .zero
      isSwiped = false
    }
  }
  
  enum SwipeDirection {
    case left
    case right
  }
}

struct EmptyModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
  }
}
