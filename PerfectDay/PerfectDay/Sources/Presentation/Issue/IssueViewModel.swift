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
    let coorChangeSbj = PassthroughSubject<Coordinate, Never>()

    fileprivate let tagButtonSbj = PassthroughSubject<Void, Never>()
    fileprivate let confirmSbj = PassthroughSubject<Void, Never>()
    fileprivate let stateButtonSbj = PassthroughSubject<Void, Never>()
    fileprivate let mapButtonSbj = PassthroughSubject<Void, Never>()
  }

  enum Action {
    case tagTapped
    case confirmTapped
    case stateTapped
    case mapTapped
    case coorChanged(Coordinate)
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
    case .mapTapped:
      input.mapButtonSbj.send()
    case .coorChanged(let coor):
      input.coorChangeSbj.send(coor)
    }
  }

  struct Output {
    var tagSheetisShow: Bool = false
    var stateSheetisShow: Bool = false
    var expireisShow: Bool = false
    var expierAlertShow: Bool = false
    var locationisShow: Bool = false
    var mapSheetisShow: Bool = false
    var location: MKCoordinateRegion = MKCoordinateRegion()
    var tags: [Tag] = []
    var issueState: IssueState = .backlog
    var viewMode: ViewMode = .modal
  }

  var input = Input()
  @Published var output = Output()
  private var cancellables = Set<AnyCancellable>()

  var issue: Issue?
  private let usecase: IssueUsecase

  init(
    usecase: IssueUsecase,
    issue: Issue? = nil,
    viewMode: ViewMode = .modal
  ) {
    self.usecase = usecase
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

    if let coordinate = issue?.coordinate {
      let latitude = coordinate.latitude
      let longitude = coordinate.longtitude
      output.location = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
          latitude: latitude,
          longitude: longitude
        ),
        span: MKCoordinateSpan(
          latitudeDelta: 0.001,
          longitudeDelta: 0.001
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
      .flatMap { [weak self] toggle -> AnyPublisher<UserState, Never> in
        guard let self else {
          return Empty(outputType: UserState.self, failureType: Never.self)
            .eraseToAnyPublisher()
        }
        if !toggle {
          self.output.expireisShow = toggle
          return Empty(outputType: UserState.self, failureType: Never.self)
            .eraseToAnyPublisher()
        } else {
          return usecase.checkNotificationAuth()
        }
      }
      .receive(on: RunLoop.main)
      .sink(receiveValue: { [weak self] in
        guard let self else { return }
        if $0 == .approved {
          self.output.expireisShow = true
        } else {
          self.output.expireisShow = false
          self.output.expierAlertShow = true
        }
      })
      .store(in: &cancellables)

    input.locationToggle.subject
      .throttle(for: 0.1, scheduler: RunLoop.main, latest: false)
      .receive(on: RunLoop.main)
      .sink(receiveValue: { [weak self] in
        guard let self else { return }
        self.output.locationisShow = $0
      })
      .store(in: &cancellables)

    input.mapButtonSbj
      .throttle(for: 0.1, scheduler: RunLoop.main, latest: false)
      .receive(on: RunLoop.main)
      .sink(receiveValue: { [weak self] in
        guard let self else { return }
        self.output.mapSheetisShow = true
      })
      .store(in: &cancellables)

    input.coorChangeSbj
      .receive(on: RunLoop.main)
      .sink(receiveValue: { [weak self] in
        guard let self else { return }
        self.output.location = MKCoordinateRegion(
          center: CLLocationCoordinate2D(
            latitude: $0.latitude,
            longitude: $0.longtitude
          ),
          span: MKCoordinateSpan(
            latitudeDelta: 0.001,
            longitudeDelta: 0.001
          )
        )
      })
      .store(in: &cancellables)
  }

}
