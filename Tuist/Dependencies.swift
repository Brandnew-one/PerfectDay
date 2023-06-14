//
//  Dependencies.swift
//  Config
//
//  Created by Bran on 2023/06/14.
//

import ProjectDescription

let spm = SwiftPackageManagerDependencies([
  .remote(url: "https://github.com/realm/realm-swift", requirement: .branch("master")),
  .remote(url: "https://github.com/Alamofire/Alamofire", requirement: .upToNextMajor(from: "5.6.0"))
])

let dependency = Dependencies(
  swiftPackageManager: spm,
  platforms: [.iOS]
)
