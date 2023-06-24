//
//  BindingSubject.swift
//  PerfectDay
//
//  Created by Bran on 2023/06/24.
//  Copyright © 2023 sangwon. All rights reserved.
//

import Combine
import Foundation

struct BindingSubject<T> {
  let subject = PassthroughSubject<T, Never>()
  var value: T {
    didSet { subject.send(value) }
  }
}
