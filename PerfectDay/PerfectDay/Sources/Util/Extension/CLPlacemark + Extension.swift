//
//  CLPlacemark + Extension.swift
//  PerfectDay
//
//  Created by Bran on 2023/07/04.
//  Copyright © 2023 sangwon. All rights reserved.
//

import CoreLocation
import Foundation

extension CLPlacemark {
  var compactAddress: String {
    var address: String = ""

    if let country = country {
      address += "\(country) "
    }

    if let locality = locality {
      address += "\(locality) "
    }

    if let name = name {
      address += "\(name)"
    }

    return address
  }
}
