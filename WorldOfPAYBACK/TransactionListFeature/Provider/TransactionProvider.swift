//
//  TransactionProvider.swift
//  WorldOfPAYBACK
//
//  Created by Aleksey Klyonov on 10.09.2023.
//

import Foundation
import ComposableArchitecture

class TransactionProvider {
    private let service: TransactionService
    private var transactions: [PBTransaction] = []
    
    init(service: TransactionService) {
        self.service = service
    }
    
    func load() async throws -> [PBTransaction] {
        let apiTransactionsObject = try await service.fetch()
        transactions = apiTransactionsObject.items
            .compactMap { self.transform(value: $0) }
            .sorted { $0.bookingDate > $1.bookingDate }
        
        return transactions
    }
    
    func filter(category: Category) -> [PBTransaction] {
        category == .all
            ? transactions
        : transactions.filter { $0.category == category.rawValue }
    }
    
    private func transform(value: APITransaction) -> PBTransaction? {
        guard let date = parseDate(string: value.transactionDetail.bookingDate) else {
            return nil
        }
        
        return PBTransaction(bookingDate: date,
                             partnerDisplayName: value.partnerDisplayName,
                             transactionDescription: value.transactionDetail.description ?? "-",
                             amount: value.transactionDetail.value.amount,
                             currency: value.transactionDetail.value.currency,
                             category: value.category)
    }
    
    private func parseDate(string: String) -> Date? {
        let isoDateFormatter = ISO8601DateFormatter()
        return isoDateFormatter.date(from: string)
    }
}

// MARK: - Register dependencies

extension TransactionProvider: DependencyKey {
    @Dependency(\.transactionService) private static var service
    static let liveValue = TransactionProvider(service: service)
}

extension DependencyValues {
    var transactionProvider: TransactionProvider {
        get { self[TransactionProvider.self] }
        set { self[TransactionProvider.self] = newValue }
    }
}
