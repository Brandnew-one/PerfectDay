//
//  BacklogListViewModel.swift
//  PerfectDay
//
//  Created by Bran on 2023/06/24.
//  Copyright © 2023 sangwon. All rights reserved.
//

import Combine
import Foundation

final class BacklogListViewModel: ObservableObject {
  struct Input {
    var searchText = BindingSubject<String>(value: "")
    fileprivate let addIssueSbj = PassthroughSubject<Void, Never>()
  }

  enum Action {
    case addIssueTapped
  }

  func action(_ action: Action) {
    switch action {
    case .addIssueTapped:
      input.addIssueSbj.send()
    }
  }

  struct Output {
    var issueSheetisShow = false
  }

  var input = Input()
  @Published var output = Output()
  private var cancellabels = Set<AnyCancellable>()

  init() {
    transform()
  }

  private func transform() {
    input.addIssueSbj
      .throttle(for: 0.1, scheduler: RunLoop.main, latest: false)
      .sink(receiveValue: { [weak self] _ in
        guard let self else { return }
        self.output.issueSheetisShow = true
      })
      .store(in: &cancellabels)
  }

}
