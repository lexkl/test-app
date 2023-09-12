//
//  TransactionService.swift
//  WorldOfPAYBACK
//
//  Created by Aleksey Klyonov on 09.09.2023.
//

import Foundation
import ComposableArchitecture

enum MockTransactionServiceError: Error {
    case noSuchFile
    case invalidRequest
}

protocol TransactionService {
    func fetch() async throws -> APITransactionsObject
}

// MARK: - Register dependencies

enum TransactionServiceKey: DependencyKey {
    static var liveValue: TransactionService = TransactionServiceMock()
}

extension DependencyValues {
    var transactionService: TransactionService {
      get { self[TransactionServiceKey.self] }
      set { self[TransactionServiceKey.self] = newValue }
    }
}
