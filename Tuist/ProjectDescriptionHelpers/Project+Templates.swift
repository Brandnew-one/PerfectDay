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

    var infoPlist: [String: InfoPlist.Value] = [
      "CFBundleShortVersionString": "1.0",
      "CFBundleVersion": "1",
      "UILaunchStoryboardName": "LaunchScreen",
      "Fonts provided by application": [
        "LINESeedKR-Rg.otf", "LINESeedKR-Th.otf"
      ]
    ]

    let locationAuth: [String: InfoPlist.Value] = [
      "NSLocationAlwaysAndWhenInUseUsageDescription":
        "위치 알림 서비스를 위해서는 위치 정보 동의가 필요해요",
      "NSLocationWhenInUseUsageDescription":
        "현재 위치를 알기 위해서는 위치 정보 동의가 필요해요"
    ]

    locationAuth.forEach { infoPlist[$0] = $1 }

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
