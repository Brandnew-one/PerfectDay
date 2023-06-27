import ProjectDescription

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://docs.tuist.io/guides/helpers/

extension Project {
  /// Helper function to create the Project for this ExampleApp
  public static func app(
    name: String,
    platform: Platform,
    organizationName: String,
    dependencies: [TargetDependency]
  ) -> Project {
    var targets = makeAppTargets(
      name: name,
      projectName: name,
      platform: platform,
      dependencies: dependencies
    )

    return Project(
      name: name,
      organizationName: organizationName,
      options: .options(
        disableBundleAccessors: true,
        disableSynthesizedResourceAccessors: true
      ),
      packages: [
        .remote(
          url: "https://github.com/realm/realm-swift.git",
          requirement: .upToNextMinor(from: "10.40.0")
        )
      ],
      targets: targets
    )
  }

  /// Helper function to create the application target and the unit test target.
  private static func makeAppTargets(
    name: String,
    projectName: String,
    platform: Platform,
    dependencies: [TargetDependency]
  ) -> [Target] {
    let platform: Platform = platform
    let infoPlist: [String: InfoPlist.Value] = [
      "CFBundleShortVersionString": "1.0",
      "CFBundleVersion": "1",
      "UIMainStoryboardFile": "",
      "UILaunchStoryboardName": "LaunchScreen",
      "Fonts provided by application": [
        "LINESeedKR-Rg.otf", "LINESeedKR-Th.otf"
      ]
    ]

    let mainTarget = Target(
      name: name,
      platform: platform,
      product: .app,
      bundleId: "io.sangwon.\(name)",
      deploymentTarget: .iOS(targetVersion: "16.0", devices: .iphone),
      infoPlist: .extendingDefault(with: infoPlist),
      sources: ["\(projectName)/\(name)/Sources/**"],
      resources: ["\(projectName)/\(name)/Resources/**"],
      scripts: [.localizedString],
      dependencies: dependencies
    )

    let testTarget = Target(
      name: "\(name)Tests",
      platform: platform,
      product: .unitTests,
      bundleId: "io.sangwon.\(name)Tests",
      infoPlist: .default,
      sources: ["\(projectName)/\(name)Test/**"],
      dependencies: [
        .target(name: "\(name)")
      ])
    return [mainTarget, testTarget]
  }
}
