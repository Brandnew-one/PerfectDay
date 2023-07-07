//
//  LocationRepositoryIpml.swift
//  PerfectDay
//
//  Created by Bran on 2023/07/04.
//  Copyright © 2023 sangwon. All rights reserved.
//

import Combine
import CoreLocation
import Foundation

final class LocationRepositoryIpml: LocationRepository {
  /// CLLocation Auth, Location 관련 Publisher
  var locationPublisher = CLLocationManager.LocationPublisher()
    .map {
      Coordinate(
        latitude: $0.coordinate.latitude,
        longtitude: $0.coordinate.longitude
      )
    }
    .eraseToAnyPublisher()

  /// 입력된 좌표를 기준으로 도로명 주소를 반환하는 메서드
  /// - Parameter coordinate: Mapkit에서 Center Coordinate
  /// - Returns: Center Coordinate의 도로명 주소
  func getRoadAddress(
    from coordinate: Coordinate
  ) -> AnyPublisher<String, Error> {
    Future<String, Error> { promise in
      let location = CLLocation(
        latitude: coordinate.latitude,
        longitude: coordinate.longtitude
      )
      let geocoder = CLGeocoder()
      geocoder.reverseGeocodeLocation(location) { placemarks, err in
        if let currentPlace = placemarks?.first {
          return promise(.success(currentPlace.compactAddress))
        } else {
          return promise(.failure(PDError.getRoadAddressErr))
        }
      }
    }
    .eraseToAnyPublisher()
  }


  /// 입력된 주소를 기준으로 좌표를 반환하는 메서드
  /// - Parameter address: 유저가 입력한 주소값
  /// - Returns: 주소값에 해당하는 좌표
  func getCoordinate(
    from address: String
  ) -> AnyPublisher<Coordinate, Error> {
    Future<Coordinate, Error> { promise in
      let geocoder = CLGeocoder()
      geocoder.geocodeAddressString(address) { placemarks, errors in
        if let userSearchPlace = placemarks?.first,
           let userSearchCoordinate = userSearchPlace.location {
          let coordinate = Coordinate(
            latitude: userSearchCoordinate.coordinate.latitude,
            longtitude: userSearchCoordinate.coordinate.longitude
          )
          return promise(.success(coordinate))
        } else {
          return promise(.failure(PDError.getCoordinateErr))
        }
      }
    }
    .eraseToAnyPublisher()
  }
}
