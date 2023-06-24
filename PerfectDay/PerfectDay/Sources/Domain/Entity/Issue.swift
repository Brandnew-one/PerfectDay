//
//  Issue.swift
//  PerfectDay
//
//  Created by Bran on 2023/06/19.
//  Copyright © 2023 sangwon. All rights reserved.
//

import Foundation

struct Issue: Identifiable {
  let id: UUID = UUID()
  var title: String
  var content: String
  var expireActive: Bool
  var expireDate: Date?
  var locationActive: Bool
  var latitude: Double?
  var longitude: Double?
  var tags: [Tag]

  init(
    title: String,
    content: String,
    expireActive: Bool,
    expireDate: Date? = nil,
    locationActive: Bool,
    latitude: Double? = nil,
    longitude: Double? = nil,
    tags: [Tag]
  ) {
    self.title = title
    self.content = content
    self.expireActive = expireActive
    self.expireDate = expireDate
    self.locationActive = locationActive
    self.latitude = latitude
    self.longitude = longitude
    self.tags = tags
  }
}
