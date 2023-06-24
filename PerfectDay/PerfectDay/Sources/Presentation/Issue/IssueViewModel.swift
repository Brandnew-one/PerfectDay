//
//  IssueViewModel.swift
//  PerfectDay
//
//  Created by Bran on 2023/06/24.
//  Copyright © 2023 sangwon. All rights reserved.
//

import Combine
import Foundation

final class IssueViewModel: ObservableObject {
  struct Input {
    var issueTitle = BindingSubject<String>(value: "")
    var issueContent = BindingSubject<String>(value: "")
    var expireToggle = BindingSubject<Bool>(value: false)
    var locationToggle = BindingSubject<Bool>(value: false)
    fileprivate let tagButtonSbj = PassthroughSubject<Void, Never>()
    fileprivate let confirmSbj = PassthroughSubject<Void, Never>()
  }

  enum Action {
    case tagTapped
    case confirmTapped
  }

  enum ViewMode {
    case push
    case modal
  }

  func action(_ action: Action) {
    switch action {
    case .tagTapped:
      input.tagButtonSbj.send()
    case .confirmTapped:
      input.confirmSbj.send()
    }
  }

  struct Output {
    var tagSheetisShow: Bool = false
    var expireisShow: Bool = false
    var locationisShow: Bool = false
    var tags: [Tag] = []
    var viewMode: ViewMode = .modal
  }

  var input = Input()
  @Published var output = Output()
  private var cancellables = Set<AnyCancellable>()

  private var issue: Issue?

  init(
    issue: Issue? = nil,
    viewMode: ViewMode = .modal
  ) {
    self.issue = issue
    self.output.viewMode = viewMode
    if let issue = issue {
      input.issueTitle.value = issue.title
      input.issueContent.value = issue.content
      input.expireToggle.value = issue.expireActive
      input.locationToggle.value = issue.locationActive
      output.tags = issue.tags
    }

    transform()
  }

  private func transform() {
    input.tagButtonSbj
      .throttle(for: 0.1, scheduler: RunLoop.main, latest: false)
      .sink(receiveValue: { [weak self] _ in
        guard let self else { return }
        self.output.tagSheetisShow = true
      })
      .store(in: &cancellables)
  }

}
