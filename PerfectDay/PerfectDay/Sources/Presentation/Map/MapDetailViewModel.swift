//
//  MapDetailViewModel.swift
//  PerfectDay
//
//  Created by Bran on 2023/07/04.
//  Copyright © 2023 sangwon. All rights reserved.
//

import Combine
import Foundation
import MapKit

final class MapDetailViewModel: ObservableObject {
  struct Input {
    var coordinateSbj = BindingSubject<MKCoordinateRegion>(value: MKCoordinateRegion())

    fileprivate let resetPositionSbj = PassthroughSubject<Void, Never>()
  }

  enum Action {
    case resetPosition
  }

  func action(_ action: Action) {
    switch action {
    case .resetPosition:
      input.resetPositionSbj.send()
    }
  }

  struct Output {
    var centerCoordinate: Coordinate = Coordinate(latitude: 1, longtitude: 1)
    var centerAddress: String = ""
    var isChanging: Bool = false
  }

  var input = Input()
  @Published var output = Output()
  private var cancellables = Set<AnyCancellable>()

  private var coordinate: Coordinate?
  private let usecase: IssueUsecase

  init(
    usecase: IssueUsecase,
    coordinate: Coordinate? = nil
  ) {
    self.usecase = usecase
    self.coordinate = coordinate

    if let coordinate = coordinate {
      input.coordinateSbj.value = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
          latitude: coordinate.latitude,
          longitude: coordinate.longtitude
        ),
        span: MKCoordinateSpan(
          latitudeDelta: 0.005,
          longitudeDelta: 0.005
        )
      )
    }

    transform()
  }

  private func transform() {
    input.coordinateSbj.subject
      .throttle(for: 0.3, scheduler: RunLoop.main, latest: false)
      .sink(receiveValue: { [weak self] in
        guard let self else { return }
        self.output.isChanging = true
        self.output.centerCoordinate = Coordinate(
          latitude: $0.center.latitude,
          longtitude: $0.center.longitude
        )
      })
      .store(in: &cancellables)

    input.coordinateSbj.subject
      .debounce(for: 0.3, scheduler: RunLoop.main)
      .flatMap { [weak self] coor -> AnyPublisher<String, Never> in
        guard let self else {
          return Empty(outputType: String.self, failureType: Never.self)
            .eraseToAnyPublisher()
        }
        return self.usecase.getCetnerPosAddress(
          Coordinate(
            latitude: coor.center.latitude,
            longtitude: coor.center.longitude
          )
        )
        .catch { _ in // TODO: - Error Handeling
          self.output.isChanging = false
          return Empty(outputType: String.self, failureType: Never.self)
            .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
      }
      .sink(receiveValue: { [weak self] in
        guard let self else { return }
        self.output.isChanging = false
        self.output.centerAddress = $0
      })
      .store(in: &cancellables)

    input.resetPositionSbj
      .throttle(for: 0.3, scheduler: RunLoop.main, latest: false)
      .flatMap { [weak self] _ -> AnyPublisher<Coordinate, Never> in
        guard let self else {
          return Empty(outputType: Coordinate.self, failureType: Never.self)
            .eraseToAnyPublisher()
        }
        return self.usecase.locationPublisher
          .catch { _ in
            // TODO: - Error Handling
            return Empty(outputType: Coordinate.self, failureType: Never.self)
              .eraseToAnyPublisher()
          }
          .eraseToAnyPublisher()
      }
      .sink(receiveValue: { [weak self] in
        guard let self else { return }
        self.input.coordinateSbj.value = MKCoordinateRegion(
          center: CLLocationCoordinate2D(
            latitude: $0.latitude,
            longitude: $0.longtitude
          ),
          span: MKCoordinateSpan(
            latitudeDelta: 0.005,
            longitudeDelta: 0.005
          )
        )
      })
      .store(in: &cancellables)
  }

}
