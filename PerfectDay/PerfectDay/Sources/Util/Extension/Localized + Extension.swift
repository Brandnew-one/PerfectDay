//
//  Localized + Extension.swift
//  PerfectDay
//
//  Created by Bran on 2023/06/17.
//  Copyright © 2023 sangwon. All rights reserved.
//

import Foundation

enum LS: String {
  case backlog

  var localized: String {
    NSLocalizedString(self.rawValue, comment: "")
  }
}
