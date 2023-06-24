//
//  BacklogItemView.swift
//  PerfectDay
//
//  Created by Bran on 2023/06/19.
//  Copyright © 2023 sangwon. All rights reserved.
//

import CoreLocation
import SwiftUI

struct BacklogItemView: View {
  private let issue: Issue

  init(issue: Issue) {
    self.issue = issue
  }

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(issue.title)
        .foregroundColor(.pdMainText)
        .font(.pdBody1)

//      Text(issue.content)
//        .foregroundColor(.pdSubText)
//        .font(.pdBody2)

      HStack {
        if issue.locationActive {
          Text("이슈 위치")
            .foregroundColor(.pdSubText)
            .font(.pdBody3)

//          if let _ = issue.latitude,
//             let _ = issue.longitude {}
        }

        Spacer()

        if issue.expireActive {
          Text("이슈 마감일")
            .foregroundColor(.pdSubText)
            .font(.pdBody3)

//          if let expireDate = issue.expireDate {}
        }
      }

      HStack {
        ForEach(issue.tags) { tag in
          TagView(tag: tag)
        }
      }
    }
    .padding()
    .background(Color.pdMainBackground)
    .cornerRadius(12)
  }
}
