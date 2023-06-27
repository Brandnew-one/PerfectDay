//
//  Dependencies.swift
//  Config
//
//  Created by Bran on 2023/06/14.
//

import ProjectDescription

let spm = SwiftPackageManagerDependencies([
//  .remote(url: "https://github.com/realm/realm-swift.git", requirement: .upToNextMinor(from: "10.40.0")),
  .remote(url: "https://github.com/Alamofire/Alamofire", requirement: .upToNextMajor(from: "5.6.0"))
])

//let carthage = CarthageDependencies([
//  .github(path: "realm/realm-cocoa", requirement: .upToNext("10.40.0"))
//])

let dependency = Dependencies(
//  carthage: carthage,
  swiftPackageManager: spm,
  platforms: [.iOS]
)
