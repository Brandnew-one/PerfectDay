//
//  Button + Extension.swift
//  PerfectDay
//
//  Created by Bran on 2023/06/24.
//  Copyright © 2023 sangwon. All rights reserved.
//

import SwiftUI

private struct ButtonWrapper: ViewModifier {
  let action: () -> Void

  init(action: @escaping () -> Void) {
    self.action = action
  }

  func body(content: Content) -> some View {
    Button(
      action: action,
      label: { content }
    )
  }
}

extension View {
  public func wrapToButton(
    action: @escaping () -> Void
  ) -> some View {
    modifier(ButtonWrapper(action: action))
  }
}
