//
//  TransactionListFeature.swift
//  WorldOfPAYBACK
//
//  Created by Aleksey Klyonov on 09.09.2023.
//

import Foundation
import ComposableArchitecture

struct TransactionListReducer: Reducer {
    @Dependency(\.transactionProvider) var transactionProvider
    @Dependency(\.networkMonitor) var networkMonitor
    
    var body: some ReducerOf<Self> {
      Reduce { state, action in
          switch action {
          case .onAppear:
              return .run { send in
                  for await value in networkMonitor.publisher
                    .last()
                    .map({ Action.networkStatusChanged($0) }).values {
                        await send(value)
                    }
              }
          case .load:
              state.isLoading = true
              return .run { send in
                  await send(.loadResponse(TaskResult {
                      return try await transactionProvider.load()
                  }))
              }
          case .loadResponse(.failure):
              state.isLoading = false
              state.destination = .alert(
                AlertState(
                    title: { TextState("An error occurred") },
                    actions: { ButtonState.default(TextState("Close")) },
                    message: { TextState("Please try again later") }))
              return .none
          case .loadResponse(.success(let transactions)):
              state.isLoading = false
              state.transactions = IdentifiedArrayOf(uniqueElements: transactions)
              return .none
              
          case .destination(.presented(.alert(.close))):
              state.transactions = IdentifiedArrayOf(uniqueElements: [])
              return.none
          case .destination:
              return.none
          case .path:
              return .none
              
          case .filterSelected(let category):
              state.selectedCategory = category
              state.transactions = IdentifiedArrayOf(uniqueElements: transactionProvider.filter(category: category))
              return .none
          case .networkStatusChanged(let isOnline):
              state.isDeviceOnline = isOnline
              return .none
          }
      }
      .ifLet(\.$destination, action: /Action.destination) {
          Destination()
      }
      .forEach(\.path, action: /Action.path) {
          TransactionDetailsReducer()
      }
    }
}

extension TransactionListReducer {
    struct State: Equatable {
        @PresentationState var destination: Destination.State?
        var path = StackState<TransactionDetailsReducer.State>()
        
        var transactions: IdentifiedArrayOf<PBTransaction> = []
        var transactionsAmount: Int {
            transactions.map { $0.amount }.reduce(0, +)
        }
        let categories = Category.allCases
        var selectedCategory: Category = .all
        
        var isLoading = false
        var isDeviceOnline = true
    }
    
    enum Action {
        case destination(PresentationAction<Destination.Action>)
        case path(StackAction<TransactionDetailsReducer.State, TransactionDetailsReducer.Action>)
        
        case onAppear
        
        case load
        case loadResponse(TaskResult<[PBTransaction]>)
        case filterSelected(Category)
        case networkStatusChanged(Bool)
        
        enum Alert: Equatable {
            case close
        }
    }
}
