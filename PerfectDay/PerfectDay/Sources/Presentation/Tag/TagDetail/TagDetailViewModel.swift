//
//  TagDetailViewModel.swift
//  PerfectDay
//
//  Created by Bran on 2023/06/24.
//  Copyright © 2023 sangwon. All rights reserved.
//

import Combine
import SwiftUI

final class TagDetailViewModel: ObservableObject {
  struct Input {
    fileprivate let saveButtonSbj = PassthroughSubject<Void, Never>()
    var tagTitle = BindingSubject<String>(value: "")
    var tagColor = BindingSubject<Color>(value: .white)
  }

  enum Action {
    case saveButtonTapped
  }

  func action(_ action: Action) {
    switch action {
    case .saveButtonTapped:
      input.saveButtonSbj.send()
    }
  }

  struct Output {
    var popupIsShow: Bool = false
  }

  var input = Input()
  @Published var output = Output()
  private var cancellbales = Set<AnyCancellable>()

  private var tag: Tag?

  init(tag: Tag? = nil) {
    self.tag = tag
    if let tag = tag {
      input.tagTitle.value = tag.title
      input.tagColor.value = Color(tag)
    }

    transform()
  }

  private func transform() {
    // Save Button Logic
  }

}
