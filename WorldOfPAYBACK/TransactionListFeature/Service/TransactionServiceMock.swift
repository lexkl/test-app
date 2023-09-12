//
//  TransactionServiceMock.swift
//  WorldOfPAYBACK
//
//  Created by Aleksey Klyonov on 12.09.2023.
//

import Foundation

struct TransactionServiceMock: TransactionService {
    func fetch() async throws -> APITransactionsObject {
        let success = Bool.random()
        
        try await Task.sleep(until: .now + .seconds(2), clock: .continuous)
        
        if success {
            return try loadFromJSON(fileName: "PBTransactions")
        } else {
            throw MockTransactionServiceError.invalidRequest
        }
    }
    
    private func loadFromJSON(fileName: String) throws -> APITransactionsObject {
        do {
            guard let filePath = Bundle.main.path(forResource: fileName, ofType: "json") else {
                throw MockTransactionServiceError.noSuchFile
            }
            
            let fileUrl = URL(fileURLWithPath: filePath)
            let data = try Data(contentsOf: fileUrl)
            return try JSONDecoder().decode(APITransactionsObject.self, from: data)
        } catch {
           throw error
        }
    }
}
