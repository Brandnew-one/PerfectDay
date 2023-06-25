//
//  BoardTabViewModel.swift
//  PerfectDay
//
//  Created by Bran on 2023/06/25.
//  Copyright © 2023 sangwon. All rights reserved.
//

import Combine
import Foundation

final class BoardTabViewModel: ObservableObject {
  struct Input {
    fileprivate let issueChangeSbj = PassthroughSubject<Void, Never>()
  }

  enum Action {
    case issueChanged
  }

  func action(_ action: Action) {
    switch action {
    case .issueChanged:
      input.issueChangeSbj.send()
    }
  }

  struct Output {
    var todo: [Issue] = []
    var onprogress: [Issue] = []
    var done: [Issue] = []
    var suspend: [Issue] = []
  }

  var input = Input()
  @Published var output = Output()
  private var cancellables = Set<AnyCancellable>()

  // TODO: - init 시점, Issue 상태별 분류
  init() {
    output.todo = mockIssues
    output.onprogress = mockIssues
    output.done = mockIssues
    output.suspend = mockIssues
  }

  private func transform() {
    // TODO: - Issue changed
    input.issueChangeSbj
      .throttle(for: 0.3, scheduler: RunLoop.main, latest: false)
      .sink(receiveValue: { [weak self] _ in
        guard let self else { return }
      })
      .store(in: &cancellables)
  }
}
