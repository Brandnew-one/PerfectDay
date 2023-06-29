//
//  NotificationRepository.swift
//  PerfectDay
//
//  Created by Bran on 2023/06/28.
//  Copyright © 2023 sangwon. All rights reserved.
//

import Combine
import Foundation

protocol NotificationRepository {
  func checkNotificationUserAuth() -> AnyPublisher<UserState, Never>  
}
