//
//  TransactionServiceAPI.swift
//  WorldOfPAYBACK
//
//  Created by Aleksey Klyonov on 12.09.2023.
//

import Foundation
import Dependencies

struct TransactionServiceAPI: TransactionService {
    @Dependency(\.networkAgent) private var networkAgent
    
    func fetch() async throws -> APITransactionsObject {
        let request = GetTransactionsRequest()
        let result: Result<APITransactionsObject, Error> = await networkAgent.send(request: request)
        
        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        }
    }
}
