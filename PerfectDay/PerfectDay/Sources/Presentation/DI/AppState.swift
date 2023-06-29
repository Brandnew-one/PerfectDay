//
//  AppState.swift
//  PerfectDay
//
//  Created by Bran on 2023/06/30.
//  Copyright © 2023 sangwon. All rights reserved.
//

import Foundation

final class AppState: ObservableObject {
  let di: AppDIInterface

  init(di: AppDIInterface) {
    self.di = di
  }
}
