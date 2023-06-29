//
//  IssueListView.swift
//  PerfectDay
//
//  Created by Bran on 2023/06/25.
//  Copyright © 2023 sangwon. All rights reserved.
//

import SwiftUI

// MARK: - 칸반보드에서 보여줄 이슈 리스트 디자인
/// 디자인 변경 고려
struct IssueListView: View {
  @EnvironmentObject
  var appState: AppState

  var issues: [Issue]

  init(issues: [Issue]) {
    self.issues = issues
  }

  var body: some View {
    ScrollView {
      LazyVStack {
        ForEach(issues) { issue in
          NavigationLink(
            destination: {
              NavigationLazyView(
                IssueView(
                  viewModel: appState.di.makeIssueViewModel(
                    issue: issue,
                    viewMode: .push
                  )
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
      }
    }
  }
}
