//
//  TagItemView.swift
//  PerfectDay
//
//  Created by Bran on 2023/06/24.
//  Copyright © 2023 sangwon. All rights reserved.
//

import SwiftUI

// MARK: - TagListItem
struct TagItemView: View {
  var tag: Tag

  @Binding
  var selectedItem: Set<UUID>

  var isSelected: Bool {
    selectedItem.contains(tag.id)
  }

  var body: some View {
    HStack {
      Text(tag.title)
        .font(.pdCaption1)
        .foregroundColor(.pdMainText)
        .padding(.horizontal, 6)
        .padding(.vertical, 4)
        .background(Color(tag))
        .cornerRadius(18)

      Spacer()

      if isSelected {
        Image(systemName: "checkmark.circle")
      } else {
        NavigationLink(
          destination: {
            TagDetailView(viewModel: TagDetailViewModel(tag: tag))
          },
          label: {
            Image(systemName: "slider.horizontal.3")
          }
        )
      }
    }
    .contentShape(Rectangle()) // for touch section
    .onTapGesture {
      if isSelected {
        selectedItem.remove(tag.id)
      } else {
        selectedItem.insert(tag.id)
      }
    }
  }
}
