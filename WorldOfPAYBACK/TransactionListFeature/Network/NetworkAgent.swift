//
//  NetworkAgent.swift
//  WorldOfPAYBACK
//
//  Created by Aleksey Klyonov on 12.09.2023.
//

import Foundation
import Dependencies

enum NetworkError: Error {
    case generalError
}

struct NetworkAgent {
    func send<T: Decodable>(request: DataRequest) async -> Result<T, Error> {
        guard let urlRequest = try? request.asURLRequest() else {
            return.failure(NetworkError.generalError)
            
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedData)
        } catch {
            return .failure(NetworkError.generalError)
        }
    }
}

// MARK: - Register dependencies

enum NetworkAgentKey: DependencyKey {
    static var liveValue: NetworkAgent = NetworkAgent()
}

extension DependencyValues {
    var networkAgent: NetworkAgent {
      get { self[NetworkAgentKey.self] }
      set { self[NetworkAgentKey.self] = newValue }
    }
}
