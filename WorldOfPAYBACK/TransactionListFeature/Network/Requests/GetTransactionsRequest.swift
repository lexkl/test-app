//
//  GetTransactionsRequest.swift
//  WorldOfPAYBACK
//
//  Created by Aleksey Klyonov on 12.09.2023.
//

import Foundation
import Dependencies

struct GetTransactionsRequest: DataRequest {
    @Dependency(\.networkConfiguration ) private var configuration: NetworkConfiguration
    
    var url: String {
        configuration.baseURL
    }
    
    let method: HTTPMethod = .get
}
