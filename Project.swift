import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

/*
                +-------------+
                |             |
                |     App     | Contains PerfectDay App target and PerfectDay unit-test target
                |             |
         +------+-------------+-------+
         |         depends on         |
         |                            |
 +----v-----+                   +-----v-----+
 |          |                   |           |
 |   Kit    |                   |     UI    |   Two independent frameworks to share code and start modularising your app
 |          |                   |           |
 +----------+                   +-----------+

 */

// MARK: - Project


let project = Project.app(
  name: "PerfectDay",
  platform: .iOS,
  organizationName: "sangwon",
  dependencies: [
    .external(name: "Realm"),
    .external(name: "Alamofire")
  ]
)
