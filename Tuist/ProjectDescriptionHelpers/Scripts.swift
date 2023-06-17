//
//  Scripts.swift
//  PerfectDayManifests
//
//  Created by Bran on 2023/06/17.
//

import ProjectDescription

public extension TargetScript {
//  static let localizedString = TargetScript.pre(
//    path: "Scripts/Localized.sh",
//    name: "Localized"
//  )

  static let localizedString = TargetScript.pre(
    script:
    """
    pip3 install google-api-python-client

    save_directory='PerfectDay/PerfectDay/Resources/Localized/'
    script_directory='Scripts/Localized.py'
    credential_directory='Scripts/credentials.json'

    python3 $script_directory $save_directory $credential_directory

    """
    ,
    name: "Localized"
  )
}
