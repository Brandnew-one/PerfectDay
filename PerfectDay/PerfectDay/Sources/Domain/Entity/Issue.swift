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
  var state: IssueState
  var title: String
  var content: String
  var expireActive: Bool
  var expireDate: Date?
  var locationActive: Bool
  var coordinate: Coordinate?
  var tags: [Tag]

  init(
    state: IssueState = .backlog,
    title: String,
    content: String,
    expireActive: Bool,
    expireDate: Date? = nil,
    locationActive: Bool,
    coordinate: Coordinate? = nil,
    tags: [Tag]
  ) {
    self.state = state
    self.title = title
    self.content = content
    self.expireActive = expireActive
    self.expireDate = expireDate
    self.locationActive = locationActive
    self.coordinate = coordinate
    self.tags = tags
  }
}

// FIXME: -
struct Coordinate {
  let latitude: Double
  let longtitude: Double
}
