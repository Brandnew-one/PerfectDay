//
//  BacklogListView.swift
//  PerfectDay
//
//  Created by Bran on 2023/06/19.
//  Copyright © 2023 sangwon. All rights reserved.
//

import SwiftUI

struct BacklogListView: View {
  @StateObject
  var viewModel: BacklogListViewModel

  var body: some View {
    ZStack(alignment: .bottomTrailing) {
      ScrollView {
        LazyVStack {
          ForEach(mockIssues) { issue in
            NavigationLink(
              destination: {
                IssueView(
                  viewModel: IssueViewModel(
                    issue: issue,
                    viewMode: .push
                  )
                )
              },
              label: {
                BacklogItemView(issue: issue)
                  .padding(.top, 8)
                  .padding(.horizontal, 8)
              }
            )
          }

          Divider().opacity(0)
            .frame(height: 20)
        }
      }
      .searchable(text: $viewModel.input.searchText.value)
      .navigationTitle("백로그")
      .navigationBarTitleDisplayMode(.automatic)
      .clipped()
      .background(Color.pdSubBackground)

      Image(systemName: "plus.circle.fill")
        .renderingMode(.template)
        .resizable()
        .foregroundColor(.pdPrimary)
        .frame(width: 40, height: 40)
        .padding()
        .wrapToButton { viewModel.action(.addIssueTapped) }
    }
    .sheet(isPresented: $viewModel.output.issueSheetisShow) {
      IssueView(viewModel: IssueViewModel(viewMode: .modal))
    }
  }
}
