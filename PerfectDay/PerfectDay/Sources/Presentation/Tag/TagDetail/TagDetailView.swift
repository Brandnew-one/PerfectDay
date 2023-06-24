//
//  TagDetailView.swift
//  PerfectDay
//
//  Created by Bran on 2023/06/24.
//  Copyright © 2023 sangwon. All rights reserved.
//

import SwiftUI

// MARK: 태그 생성 / 수정
struct TagDetailView: View {
  @StateObject
  var viewModel: TagDetailViewModel

  var body: some View {
    VStack {
      tagNameSection

      tagColorSection

      Spacer()
    }
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Text("저장")
      }
    }
  }
}

extension TagDetailView {
  var tagNameSection: some View {
    VStack(alignment:. leading, spacing: 8) {
      Text("태그 이름")
        .font(.pdTitle2)
        .foregroundColor(.pdMainText)

      TextField("Tag Name", text: $viewModel.input.tagTitle.value)
        .font(.pdBody2)
        .foregroundColor(.pdSubText)
    }
    .padding()
  }

  var tagColorSection: some View {
    HStack {
      Text("태그 컬러")
        .font(.pdTitle2)
        .foregroundColor(.pdMainText)

      Spacer()

      ColorPicker("", selection: $viewModel.input.tagColor.value)
    }
    .padding()
  }
}

