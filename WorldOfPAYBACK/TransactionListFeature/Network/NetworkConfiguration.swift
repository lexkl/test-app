//
//  NetworkConfiguration.swift
//  WorldOfPAYBACK
//
//  Created by Aleksey Klyonov on 12.09.2023.
//

import Foundation
import Dependencies

struct NetworkConfiguration {
    let baseURL: String
}

// MARK: - Register dependencies

enum NetworkConfigurationKey: DependencyKey {
    private static let plistLoader = PlistLoader()
    private static let urlLoader = URLLoader(loader: plistLoader)
    static var liveValue: NetworkConfiguration = NetworkConfiguration(baseURL: urlLoader.load()[.production]!)
}

extension DependencyValues {
    var networkConfiguration: NetworkConfiguration {
      get { self[NetworkConfigurationKey.self] }
      set { self[NetworkConfigurationKey.self] = newValue }
    }
}
