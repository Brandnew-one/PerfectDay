//
//  IssueViewModel.swift
//  PerfectDay
//
//  Created by Bran on 2023/06/24.
//  Copyright © 2023 sangwon. All rights reserved.
//

import Combine
import Foundation
import MapKit

// FIXME: - CoreLocation 동의시에만 Map 기능 사용할 수 있도록 제한하기
final class IssueViewModel: ObservableObject {
  struct Input {
    var issueTitle = BindingSubject<String>(value: "")
    var issueContent = BindingSubject<String>(value: "")
    var expireToggle = BindingSubject<Bool>(value: false)
    var expireDate = BindingSubject<Date>(value: Date())
    var locationToggle = BindingSubject<Bool>(value: false)
    fileprivate let tagButtonSbj = PassthroughSubject<Void, Never>()
    fileprivate let confirmSbj = PassthroughSubject<Void, Never>()
    fileprivate let stateButtonSbj = PassthroughSubject<Void, Never>()
  }

  enum Action {
    case tagTapped
    case confirmTapped
    case stateTapped
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
    case .stateTapped:
      input.stateButtonSbj.send()
    }
  }

  struct Output {
    var tagSheetisShow: Bool = false
    var stateSheetisShow: Bool = false
    var expireisShow: Bool = false
    var locationisShow: Bool = false
    var location: MKCoordinateRegion = MKCoordinateRegion()
    var tags: [Tag] = []
    var issueState: IssueState = .backlog
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
      output.expireisShow = issue.expireActive
      output.locationisShow = issue.locationActive
      output.issueState = issue.state
    }

    if let expireDate = issue?.expireDate {
      input.expireDate.value = expireDate
    }

    if let latitude = issue?.latitude,
       let longtitue = issue?.longitude {
      output.location = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
          latitude: latitude,
          longitude: longtitue
        ),
        span: MKCoordinateSpan(
          latitudeDelta: 0.1,
          longitudeDelta: 0.1
        )
      )
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

    input.stateButtonSbj
      .throttle(for: 0.1, scheduler: RunLoop.main, latest: false)
      .sink(receiveValue: { [weak self] _ in
        guard let self else { return }
        self.output.stateSheetisShow = true
      })
      .store(in: &cancellables)

    input.expireToggle.subject
      .throttle(for: 0.1, scheduler: RunLoop.main, latest: false)
      .sink(receiveValue: { [weak self] in
        guard let self else { return }
        self.output.expireisShow = $0
      })
      .store(in: &cancellables)

    input.locationToggle.subject
      .throttle(for: 0.1, scheduler: RunLoop.main, latest: false)
      .sink(receiveValue: { [weak self] in
        guard let self else { return }
        self.output.locationisShow = $0
      })
      .store(in: &cancellables)
  }

}
