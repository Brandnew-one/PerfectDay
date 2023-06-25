//
//  TestView.swift
//  PerfectDay
//
//  Created by Bran on 2023/06/15.
//  Copyright © 2023 sangwon. All rights reserved.
//

import SwiftUI

// FIXME: - 임시 파일
enum TabItem {
  case backlog
  case board
  case setting

  var title: String {
    switch self {
    case .backlog:
      return "백로그"
    case .board:
      return "보드"
    case .setting:
      return "설정"
    }
  }

  var image: Image {
    switch self {
    case .backlog:
      return Image(systemName: "backpack")
    case .board:
      return Image(systemName: "list.clipboard")
    case .setting:
      return Image(systemName: "gear")
    }
  }
}

struct TestView: View {
  @State
  private var selectedTab: TabItem = .backlog

  var body: some View {
    TabView(selection: $selectedTab) {
      NavigationView {
        BacklogListView(viewModel: BacklogListViewModel())
      }
      .tag(TabItem.backlog)
      .tabItem {
        TabItem.backlog.image

        Text(TabItem.backlog.title)
      }

      NavigationView {
        BoardTabView(viewModel: BoardTabViewModel())
      }
      .tag(TabItem.board)
      .tabItem {
        TabItem.board.image

        Text(TabItem.board.title)
      }

      Text("사용자 설정 뷰")
        .tag(TabItem.setting)
        .tabItem {
          TabItem.setting.image

          Text(TabItem.setting.title)
        }
    }
    .accentColor(.pdPrimary)
    .onAppear {
      if #available(iOS 15.0, *) {
        let appearance = UITabBarAppearance()
        UITabBar.appearance().scrollEdgeAppearance = appearance
      }
    }
  }
}

struct TestViewProvider_Previews: PreviewProvider {
  static var previews: some View {
    TestView()
  }
}
