//
//  IssueUsecase.swift
//  PerfectDay
//
//  Created by Bran on 2023/06/25.
//  Copyright © 2023 sangwon. All rights reserved.
//

import Combine
import Foundation

final class IssueUsecase {
  private let notificationRepo: NotificationRepository
  private let locationRepo: LocationRepository

  // MARK: - Output Stream
  var locationPublisher: AnyPublisher<Coordinate, PDError>

  init(
    notificationRepo: NotificationRepository,
    locationRepo: LocationRepository
  ) {
    self.notificationRepo = notificationRepo
    self.locationRepo = locationRepo
    self.locationPublisher = locationRepo.locationPublisher
  }


  func checkNotificationAuth() -> AnyPublisher<UserState, Never> {
    notificationRepo.checkNotificationUserAuth()
  }

  func getCetnerPosAddress(
    _ centerCoordinate: Coordinate
  ) ->AnyPublisher<String, PDError> {
    locationRepo.getRoadAddress(from: centerCoordinate)
      .mapError { $0 as? PDError ?? .default }
      .eraseToAnyPublisher()
  }

}
