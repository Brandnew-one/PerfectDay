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

  init(
    notificationRepo: NotificationRepository
  ) {
    self.notificationRepo = notificationRepo
  }

  func checkNotificationAuth() -> AnyPublisher<UserState, Never> {
    notificationRepo.checkNotificationUserAuth()
  }

}
