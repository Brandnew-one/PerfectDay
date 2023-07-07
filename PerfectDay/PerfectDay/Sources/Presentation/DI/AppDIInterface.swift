//
//  AppDIInterface.swift
//  PerfectDay
//
//  Created by Bran on 2023/06/30.
//  Copyright © 2023 sangwon. All rights reserved.
//

import Combine
import Foundation

protocol AppDIInterface {
  func makeIssueViewModel(
    issue: Issue?,
    viewMode: IssueViewModel.ViewMode
  ) -> IssueViewModel

  func makeMapDetailViewModel(
    coordinate: Coordinate?,
    dismissSbj: PassthroughSubject<Coordinate, Never>
  ) -> MapDetailViewModel
}

