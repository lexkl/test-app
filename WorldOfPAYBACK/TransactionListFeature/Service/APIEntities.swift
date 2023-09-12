//
//  Entities.swift
//  WorldOfPAYBACK
//
//  Created by Aleksey Klyonov on 10.09.2023.
//

import Foundation

struct APITransactionValue: Decodable {
    let amount: Int
    let currency: String
}

struct APITransactionDetail: Decodable {
    let description: String?
    let bookingDate: String
    let value: APITransactionValue
}

struct APITransactionAlias: Decodable {
    let reference: String
}

struct APITransaction: Decodable {
    let partnerDisplayName: String
    let alias: APITransactionAlias
    let category: Int
    let transactionDetail: APITransactionDetail
}

struct APITransactionsObject: Decodable {
    let items: [APITransaction]
}
