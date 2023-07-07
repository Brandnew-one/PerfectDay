//
//  AppDI.swift
//  PerfectDay
//
//  Created by Bran on 2023/06/30.
//  Copyright © 2023 sangwon. All rights reserved.
//

import Combine
import Foundation


/// 모든 Layer를 알고 있는 App Layer
final class AppDI {

  // FIXME: - Usecase들도 나중에는 주입 받을 수 있도록 수정하기
  private lazy var issueUsecase: IssueUsecase = IssueUsecase(
    notificationRepo: NotificationRepositoryIpml(),
    locationRepo: LocationRepositoryIpml()
  )
}

extension AppDI: AppDIInterface {
  func makeIssueViewModel(
    issue: Issue? = nil,
    viewMode: IssueViewModel.ViewMode = .modal
  ) -> IssueViewModel {
    IssueViewModel(
      usecase: issueUsecase,
      issue: issue,
      viewMode: viewMode
    )
  }

  func makeMapDetailViewModel(
    coordinate: Coordinate? = nil
  ) -> MapDetailViewModel {
    MapDetailViewModel(
      usecase: issueUsecase,
      coordinate: coordinate
    )
  }
}
