//
//  NotificationRepositoryIpml.swift
//  PerfectDay
//
//  Created by Bran on 2023/06/28.
//  Copyright © 2023 sangwon. All rights reserved.
//

import Combine
import Foundation
import UserNotifications

final class NotificationRepositoryIpml: NotificationRepository {

  /// Notification 권한 설정
  /// - Returns: 유저의 권한 상태 반환
  func checkNotificationUserAuth() -> AnyPublisher<UserState, Never> {
    Future<UserState, Never> { promise in
      let userNotificationCenter = UNUserNotificationCenter.current()
      let options = UNAuthorizationOptions(arrayLiteral: [.alert, .badge, .sound])

      userNotificationCenter.requestAuthorization(options: options) { granted, err in
        if granted {
          return promise(.success(.approved))
        } else {
          return promise(.success(.denied))
        }
      }
    }
    .eraseToAnyPublisher()
  }


}
