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
  @State
  private var selection = Set<UUID>()

  @State
  private var searchText: String = ""

  @Environment(\.dismiss)
  private var dismiss

  var body: some View {
    NavigationView {
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
            .wrapToButton { dismiss() }
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
}
