//
//  TestView.swift
//  PerfectDay
//
//  Created by Bran on 2023/06/15.
//  Copyright © 2023 sangwon. All rights reserved.
//

import SwiftUI

struct TestView: View {
  var body: some View {
    ZStack {
      Rectangle()
        .foregroundColor(.pdMainBackground)

      VStack(alignment: .leading) {
        Text(LS.backlog.localized)
          .foregroundColor(.pdMainText)

        Text("이건 너무 긴데요 선생님")
          .foregroundColor(.pdSubText)
      }
      .padding()
      .background(Color.pdPrimary)
      .cornerRadius(20)
    }
  }
}

struct TestViewProvider_Previews: PreviewProvider {
  static var previews: some View {
    TestView()
  }
}
