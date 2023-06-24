//
//  Issue.swift
//  PerfectDay
//
//  Created by Bran on 2023/06/19.
//  Copyright © 2023 sangwon. All rights reserved.
//

import Foundation

struct Issue {
  var title: String
  var content: String
  var expireDate: Date?
  var latitude: Double?
  var longitude: Double?
  var tags: [Tag]

  init(
    title: String,
    content: String,
    expireDate: Date? = nil,
    latitude: Double? = nil,
    longitude: Double? = nil,
    tags: [Tag]
  ) {
    self.title = title
    self.content = content
    self.expireDate = expireDate
    self.latitude = latitude
    self.longitude = longitude
    self.tags = tags
  }
}
