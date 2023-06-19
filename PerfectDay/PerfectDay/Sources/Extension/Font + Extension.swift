//
//  Font + Extension.swift
//  PerfectDay
//
//  Created by Bran on 2023/06/19.
//  Copyright © 2023 sangwon. All rights reserved.
//

import SwiftUI

fileprivate struct PerfectDayFont {
  static let regular = "LINESeedKR-Rg"
  static let thin = "LINESeedKR-Th"
}

extension Font {
  public static let pdTitle1 = Font.custom(PerfectDayFont.regular, size: 28)
  public static let pdTitle2 = Font.custom(PerfectDayFont.regular, size: 24)
  public static let pdTitle3 = Font.custom(PerfectDayFont.regular, size: 20)

  public static let pdBody1 = Font.custom(PerfectDayFont.thin, size: 20)
  public static let pdBody2 = Font.custom(PerfectDayFont.thin, size: 18)
  public static let pdBody3 = Font.custom(PerfectDayFont.thin, size: 16)
  public static let pdBody4 = Font.custom(PerfectDayFont.thin, size: 14)

  public static let pdCaption1 = Font.custom(PerfectDayFont.thin, size: 12)
  public static let pdCaption2 = Font.custom(PerfectDayFont.thin, size: 10)
}
