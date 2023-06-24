//
//  TagListView.swift
//  PerfectDay
//
//  Created by Bran on 2023/06/24.
//  Copyright © 2023 sangwon. All rights reserved.
//

import SwiftUI

// TODO: - Trailing Button (checkvron 추가)
struct TagListView: View {
  var mockTag: [Tag] = [
    Tag(title: "SwiftUI"),
    Tag(title: "Tuist"),
    Tag(title: "PS"),
    Tag(
      title: "UIKit",
      red: 1.0,
      green: 0.33,
      blue: 0.12,
      alpha: 0.5
    )
  ]

  @State
  private var selection = Set<UUID>()

  @State
  private var searchText: String = ""

  var body: some View {
    ScrollView {
      LazyVStack {
        ForEach(mockTag) { tag in
          TagItemView(tag: tag, selectedItem: $selection)
            .padding()
        }
      }
    }
    .navigationTitle("태그")
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        Text("취소")
      }

      ToolbarItem(placement: .navigationBarTrailing) {
        NavigationLink(
          destination: {
            TagDetailView(viewModel: TagDetailViewModel())
          },
          label: {
            Text("추가")
          }
        )
      }
    }
    .searchable(text: $searchText)
  }
}
