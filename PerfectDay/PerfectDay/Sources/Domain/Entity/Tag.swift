//
//  Tag.swift
//  PerfectDay
//
//  Created by Bran on 2023/06/19.
//  Copyright © 2023 sangwon. All rights reserved.
//

import Foundation

struct Tag: Identifiable, Hashable {
  let id: UUID = UUID()
  var title: String
  var red: CGFloat
  var green: CGFloat
  var blue: CGFloat
  var alpha: CGFloat

  init(
    title: String,
    red: CGFloat = 1.0,
    green: CGFloat = 1.0,
    blue: CGFloat = 1.0,
    alpha: CGFloat = 1.0
  ) {
    self.title = title
    self.red = red
    self.green = green
    self.blue = blue
    self.alpha = alpha
  }
}
