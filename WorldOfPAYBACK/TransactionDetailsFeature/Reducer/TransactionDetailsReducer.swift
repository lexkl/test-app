//
//  TransactionDetailsReducer.swift
//  WorldOfPAYBACK
//
//  Created by Aleksey Klyonov on 11.09.2023.
//

import Foundation
import ComposableArchitecture

struct TransactionDetails: Equatable {
    let partnerName: String
    let description: String
}

struct TransactionDetailsReducer: Reducer {
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        return .none
    }
}

extension TransactionDetailsReducer {
    struct State: Equatable {
        let transaction: TransactionDetails
    }
    
    enum Action {
        
    }
}
