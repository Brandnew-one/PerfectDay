//
//  CLLocationCoordinate2D + Extension.swift
//  PerfectDay
//
//  Created by Bran on 2023/07/07.
//  Copyright © 2023 sangwon. All rights reserved.
//

import Foundation
import MapKit

extension CLLocationCoordinate2D: Equatable {
  public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
    lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
  }


}
