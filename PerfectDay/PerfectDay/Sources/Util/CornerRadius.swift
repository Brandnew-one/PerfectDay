//
//  CornerRadius.swift
//  PerfectDay
//
//  Created by Bran on 2023/06/25.
//  Copyright © 2023 sangwon. All rights reserved.
//

import SwiftUI

fileprivate struct CornerRaiusShape: Shape {
  var radius = CGFloat.infinity
  var corners = UIRectCorner.allCorners

  func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(
      roundedRect: rect,
      byRoundingCorners: corners,
      cornerRadii: CGSize(width: radius, height: radius)
    )
    return Path(path.cgPath)
  }
}

fileprivate struct CornerRadiusStyle: ViewModifier {
  var radius: CGFloat
  var corners: UIRectCorner

  func body(content: Content) -> some View {
    content
      .clipShape(
        CornerRaiusShape(radius: radius, corners: corners)
      )
  }
}

extension View {
  func cornerRadius(
    radius: CGFloat,
    corners: UIRectCorner
  ) -> some View {
    ModifiedContent(
      content: self,
      modifier: CornerRadiusStyle(radius: radius, corners: corners)
    )
  }
}
