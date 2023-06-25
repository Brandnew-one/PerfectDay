//
//  BoardTabView.swift
//  PerfectDay
//
//  Created by Bran on 2023/06/25.
//  Copyright © 2023 sangwon. All rights reserved.
//

import SwiftUI

enum BoardTabMode {
  case todo
  case onprogress
  case doen
  case susppend

  var title: String {
    switch self {
    case .todo:
      return "TODO"
    case .onprogress:
      return "ONPROGRESS"
    case .doen:
      return "DONE"
    case .susppend:
      return "SUSPEND"
    }
  }
}

struct BoardTabView: View {
  @StateObject
  var viewModel: BoardTabViewModel

  @State
  private var selectedTab: BoardTabMode = .todo

  var body: some View {
    TabView(selection: $selectedTab) {
      IssueListView(issues: viewModel.output.todo)
        .tag(BoardTabMode.todo)

      IssueListView(issues: viewModel.output.onprogress)
        .tag(BoardTabMode.onprogress)

      IssueListView(issues: viewModel.output.done)
        .tag(BoardTabMode.doen)

      IssueListView(issues: viewModel.output.suspend)
        .tag(BoardTabMode.susppend)
    }
    .tabViewStyle(.page(indexDisplayMode: .always))
    .navigationTitle(selectedTab.title)
    .navigationBarTitleDisplayMode(.large)
    .onAppear { viewModel.action(.issueChanged) }
  }
}
