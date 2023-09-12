//
//  TransactionListDestinationReducer.swift
//  WorldOfPAYBACK
//
//  Created by Aleksey Klyonov on 10.09.2023.
//

import Foundation
import ComposableArchitecture

extension TransactionListReducer {
    struct Destination: Reducer {
        enum State: Equatable {
            case alert(AlertState<TransactionListReducer.Action.Alert>)
        }
        
        enum Action: Equatable {
            case alert(TransactionListReducer.Action.Alert)
        }
        
        func reduce(into state: inout State, action: Action) -> Effect<Action> {
            return .none
        }
    }
}
