//
//  Color + Extension.swift
//  PerfectDay
//
//  Created by Bran on 2023/06/15.
//  Copyright © 2023 sangwon. All rights reserved.
//

import Foundation
import SwiftUI

// FIXME: -
/// Tuist에서 제공하는 Asset은 실제로 사용하기에 너무 길어서 불편
/// 실제 회사 프로젝트에서는 어떻게 관리해야할지 생각해보기
private class PerfectDayBundleClass {}

extension Bundle {
  class var perfectdayUI: Bundle {
    Bundle(for: PerfectDayBundleClass.self)
  }
}

extension Color {
  public static let pdMainBackground = Color("MainBackground", bundle: .perfectdayUI)
  public static let pdSubBackground = Color("SubBackground", bundle: .perfectdayUI)
  public static let pdMainText = Color("MainText", bundle: .perfectdayUI)
  public static let pdSubText = Color("SubText", bundle: .perfectdayUI)
  public static let pdPrimary = Color("Primary", bundle: .perfectdayUI)

  // MARK: - init from Tag
  init(_ tag: Tag) {
    self.init(
      cgColor: CGColor(
        red: tag.red,
        green: tag.green,
        blue: tag.blue,
        alpha: tag.alpha
      )
    )
  }
}
