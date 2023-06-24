//
//  TagView.swift
//  PerfectDay
//
//  Created by Bran on 2023/06/24.
//  Copyright © 2023 sangwon. All rights reserved.
//

import SwiftUI

// MARK: - Tag 다른 탭들에서 보이는 태그들을 보여주는 뷰
struct TagView: View {
  private let tag: Tag

  init(tag: Tag) {
    self.tag = tag
  }

  var body: some View {
    Text(tag.title)
      .font(.pdCaption1)
      .foregroundColor(.pdSubText)
      .padding(.horizontal, 8)
      .padding(.vertical, 6)
      .background(Color(tag))
      .cornerRadius(18)
  }
}
