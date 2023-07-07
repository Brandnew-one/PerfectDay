//
//  LocationRepository.swift
//  PerfectDay
//
//  Created by Bran on 2023/07/04.
//  Copyright © 2023 sangwon. All rights reserved.
//

import Combine
import Foundation

protocol LocationRepository {
  var locationPublisher: AnyPublisher<Coordinate, PDError> { get }

  func getRoadAddress(
    from coordinate: Coordinate
  ) -> AnyPublisher<String, Error>

  func getCoordinate(
    from address: String
  ) -> AnyPublisher<Coordinate, Error>
}
