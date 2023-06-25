//
//  IssueState.swift
//  PerfectDay
//
//  Created by Bran on 2023/06/25.
//  Copyright © 2023 sangwon. All rights reserved.
//

import Foundation

enum IssueState {
  case backlog
  case todo
  case onprogress
  case done
  case suspend

  var title: String {
    switch self {
    case .backlog:
      return "백로그"
    case .todo:
      return "할일"
    case .onprogress:
      return "진행중"
    case .done:
      return "완료"
    case .suspend:
      return "연기"
    }
  }
}
