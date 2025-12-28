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
  
  // MARK: - Body
  
  func body(content: Content) -> some View {
    content
      .background(
        swipeBackground
          .clipShape(RoundedRectangle(cornerRadius: 24))
          .padding(.horizontal)
      )
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
  
  // MARK: - Background
  
  private var swipeBackground: some View {
    let progress = min(abs(offset.width) / 120, 1)
    
    return Group {
      if offset.width > 0 {
        Color.green.opacity(progress * 0.55)
      } else if offset.width < 0 {
        Color.red.opacity(progress * 0.55)
      } else {
        Color.clear
      }
    }
  }
  
  private var backgroundColor: Color {
    if offset.width > 0 {
      return .green
    } else if offset.width < 0 {
      return .red
    } else {
      return .clear
    }
  }
  
  // MARK: - Swipe
  
  private func completeSwipe(to direction: SwipeDirection) {
    isSwiped = true
    
    withAnimation(.easeIn(duration: 0.35)) {
      offset = CGSize(
        width: direction == .right ? 600 : -600,
        height: 0
      )
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
      switch direction {
      case .left:
        onSwipeLeft()
      case .right:
        onSwipeRight()
      case .none:
        break
      }
      
      offset = .zero
      isSwiped = false
    }
  }
  
  enum SwipeDirection {
    case left
    case right
    case none
  }
}

struct EmptyModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
  }
}
