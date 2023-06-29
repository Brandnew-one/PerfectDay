import SwiftUI

@main
struct PerfectDayApp: App {
  private let appState = AppState(di: AppDI())

  var body: some Scene {
    WindowGroup {
      TestView()
        .environmentObject(appState)
    }
  }
}

var mockIssues: [Issue] = [
  Issue(
    title: "퍼펙트데이",
    content: "퍼펙트데이 앱 만들기",
    expireActive: false,
    locationActive: false,
    tags: mockTag
  ),
  Issue(
    title: "퍼펙트데이2",
    content: "퍼펙트데이 앱 만들기2",
    expireActive: false,
    locationActive: false,
    tags: mockTag
  ),
  Issue(
    title: "퍼펙트데이3",
    content: "퍼펙트데이 앱 만들기3",
    expireActive: true,
    locationActive: true,
    tags: mockTag
  ),
  Issue(
    title: "퍼펙트데이",
    content: "퍼펙트데이 앱 만들기",
    expireActive: false,
    locationActive: false,
    tags: mockTag
  )
]

var mockTag: [Tag] = [
  Tag(title: "SwiftUI"),
  Tag(title: "Tuist"),
  Tag(title: "PS"),
  Tag(
    title: "UIKit",
    red: 1.0,
    green: 0.33,
    blue: 0.12,
    alpha: 0.5
  )
]
