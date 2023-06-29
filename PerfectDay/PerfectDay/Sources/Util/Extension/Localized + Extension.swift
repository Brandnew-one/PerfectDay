//
//  Localized + Extension.swift
//  PerfectDay
//
//  Created by Bran on 2023/06/17.
//  Copyright © 2023 sangwon. All rights reserved.
//

import Foundation

enum LS: String {
  case Issue0000
  case Issue0010
  case Issue0020
  case Issue0030
  case Issue0040
  case Issue0050
  case Issue0060
  case Issue0070
  case Issue0080


  var localized: String {
    NSLocalizedString(self.rawValue, comment: "")
  }
}
