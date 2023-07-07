//
//  Extension + Publisher.swift
//  PerfectDay
//
//  Created by Bran on 2023/07/04.
//  Copyright © 2023 sangwon. All rights reserved.
//

import Combine
import CoreLocation
import Foundation

extension CLLocationManager {
  static func publishLocation() -> LocationPublisher {
    return .init()
  }

  struct LocationPublisher: Publisher {
    public typealias Output = CLLocation
    public typealias Failure = PDError

    func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
      let subscription = LocationSubscription(subscriber: subscriber)
      subscriber.receive(subscription: subscription)
    }

    final class LocationSubscription<S: Subscriber> : NSObject, CLLocationManagerDelegate, Subscription where S.Input == Output, S.Failure == Failure {
      var subscriber: S
      var locationManager = CLLocationManager()

      init(subscriber: S) {
        self.subscriber = subscriber
        super.init()

        locationManager.delegate = self
      }

      func request(_ demand: Subscribers.Demand) {
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
      }

      func cancel() {
        locationManager.stopUpdatingLocation()
      }

      // MARK: - CLLocationManager Delegates
      func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
      ) {
        if let location = locations.last {
          _ = subscriber.receive(location)
          cancel()
        }
      }

      func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
      ) {
        if let error = error as? CLError,
           error.code == .denied {
          subscriber.receive(completion: .failure(.locationAuthErr))
        } else {
          subscriber.receive(completion: .failure(.locationAuthErr))
        }
      }

      func locationManagerDidChangeAuthorization(
        _ manager: CLLocationManager
      ) {
        switch manager.authorizationStatus {
        case .notDetermined:
          manager.requestAlwaysAuthorization()
        case .restricted, .denied:
          subscriber.receive(completion: .failure(.locationAuthErr))
        default:
          break
        }
      }
    }
  }
}
