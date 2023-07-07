//
//  Error.swift
//  PerfectDay
//
//  Created by Bran on 2023/07/04.
//  Copyright © 2023 sangwon. All rights reserved.
//

import Foundation

enum PDError: Error {
  case getRoadAddressErr
  case getCoordinateErr
  case locationAuthErr
  case `default`

  var description: String {
    switch self {
    case .getRoadAddressErr:
      return "주소명 가져오기에 실패했어요"
    case .getCoordinateErr:
      return "주소명으로부터 주소를 가져오는데 실패했어요"
    case .locationAuthErr:
      return "위치권한 설정이 필요해요"
    case .default:
      return "알 수 없는 에러가 발생했어요"
    }
  }
}
