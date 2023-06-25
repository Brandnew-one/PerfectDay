//
//  BottomSheet.swift
//  PerfectDay
//
//  Created by Bran on 2023/06/25.
//  Copyright © 2023 sangwon. All rights reserved.
//

import SwiftUI

fileprivate enum Constants {
  static let snapRatio: CGFloat = 0.1
  static let minHeightRatio: CGFloat = 0.3
}

fileprivate struct BottomSheetWrapper<SubView: View>: ViewModifier {
  @Binding
  var isShow: Bool

  let maxHeight: CGFloat = UIScreen.main.bounds.height
  let minHeight: CGFloat = UIScreen.main.bounds.height * Constants.minHeightRatio
  let subView: SubView

  @GestureState
  private var translation: CGFloat = 0

  private var offset: CGFloat {
    isShow ? 0 : maxHeight - minHeight
  }

  private var mask: some View {
    Color.black.opacity(0.4)
  }

  private let dimTouch: Bool

  fileprivate init(
    isShow: Binding<Bool>,
    dimTouch: Bool = true,
    @ViewBuilder content: () -> SubView
  ) {
    self._isShow = isShow
    self.dimTouch = dimTouch
    self.subView = content()
  }

  func body(content: Content) -> some View {
    ZStack {
      content

      ZStack(alignment: .bottom) {
        if isShow {
          mask.ignoresSafeArea()
            .onTapGesture {
              if dimTouch {
                isShow = false
              }
            }

          VStack(alignment: .leading, spacing: 0) {
            Rectangle()
              .foregroundColor(.pdMainBackground)
              .frame(height: 20)

            subView
              .padding(.bottom, 20)

            Rectangle()
              .foregroundColor(.pdMainBackground)
              .frame(height: 100) // FIXME: - TabBar Height
          }
          .background(Color.pdMainBackground)
          .cornerRadius(radius: 18, corners: [.topLeft, .topRight])
          .offset(y: max(self.offset + self.translation, 0))
          .gesture(
            DragGesture().updating(self.$translation) { value, state, _ in
              state = value.translation.height
            }.onEnded { value in
              let snapDistance = self.maxHeight * Constants.snapRatio
              guard abs(value.translation.height) > snapDistance else {
                return
              }
              self.isShow = value.translation.height < 0
            }
          )
          .transition(.move(edge: .bottom))
        }
      }
      .frame(
        maxWidth: .infinity,
        maxHeight: .infinity,
        alignment: .bottom
      )
      .ignoresSafeArea()
      .animation(.easeInOut, value: isShow)
    }
  }

}

extension View {
  public func bottomSheet<Content: View>(
    isShow: Binding<Bool>,
    @ViewBuilder content: () -> Content
  ) -> some View {
    modifier(BottomSheetWrapper(
      isShow: isShow,
      content: content
    ))
  }
}
