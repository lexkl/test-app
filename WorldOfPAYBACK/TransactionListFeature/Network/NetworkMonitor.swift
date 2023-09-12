//
//  NetworkMonitor.swift
//  WorldOfPAYBACK
//
//  Created by Aleksey Klyonov on 12.09.2023.
//

import Foundation
import Network
import Dependencies
import Combine

class NetworkMonitor {
    private let networkMonitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor", target: .global())
    private let subject = CurrentValueSubject<Bool, Never>(true)
    var publisher: AnyPublisher<Bool, Never> {
        subject.eraseToAnyPublisher()
    }

    init() {
        networkMonitor.pathUpdateHandler = { path in
            self.subject.send(path.status == .satisfied)
        }
        networkMonitor.start(queue: queue)
    }
}

// MARK: - Register dependencies

enum NetworkMonitorKey: DependencyKey {
    static var liveValue: NetworkMonitor = NetworkMonitor()
}

extension DependencyValues {
    var networkMonitor: NetworkMonitor {
      get { self[NetworkMonitorKey.self] }
      set { self[NetworkMonitorKey.self] = newValue }
    }
}
