//
//  TransactionListView.swift
//  WorldOfPAYBACK
//
//  Created by Aleksey Klyonov on 09.09.2023.
//

import SwiftUI
import ComposableArchitecture

struct TransactionListView: View {
    let store: StoreOf<TransactionListReducer>
    
    var body: some View {
        NavigationStackStore(self.store.scope(state: \.path, action: { .path($0) })) {
            WithViewStore(store, observe: { $0 }) { viewStore in
                VStack {
                    if !viewStore.isDeviceOnline {
                        EmptyView(message: "Errors.NoInternet".localized)
                    } else if viewStore.isLoading {
                        ProgressView("TransactionList.Loading.Message".localized)
                    } else {
                        VStack {
                            transactionList(viewStore.transactions.elements)
                                .refreshable {
                                    store.send(.load)
                                }
                            HStack {
                                Text("TransactionList.Total.Label".localized)
                                Spacer()
                                Text("\(viewStore.transactionsAmount) PBP")
                            }
                            .padding(.horizontal, 14)
                            .padding(.vertical, 5)
                        }
                    }
                }
                .alert(store: self.store.scope(state: \.$destination,
                                               action: { .destination($0) }),
                       state: /TransactionListReducer.Destination.State.alert,
                       action: TransactionListReducer.Destination.Action.alert)
                .toolbar {
                    ToolbarItem {
                        menu(viewStore: viewStore)
                    }
                }
            }
            .navigationTitle("TransactionList.Title".localized)
            .onAppear {
                store.send(.load)
            }
        } destination: { store in
            TransactionDetailsView(store: store)
        }
    }
    
    private func menu(viewStore: ViewStore<TransactionListReducer.State,
                                           TransactionListReducer.Action>) -> AnyView {
        Menu("TransactionList.Filter".localized) {
            Text("TransactionList.Filter.Categories".localized)
            Picker(
                "Title",
                selection: viewStore.binding(
                    get: { $0.selectedCategory },
                    send: { TransactionListReducer.Action.filterSelected($0) })) {
                        ForEach(viewStore.categories) { category in
                            Text("\(String(describing: category))")
                        }
                    }
            
        }.toAnyView()
    }
    
    private func transactionList(_ items: [PBTransaction]) -> AnyView {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        return List {
            ForEach(items) { transaction in
                NavigationLink(
                    state: TransactionDetailsReducer.State(
                        transaction: TransactionDetails(
                            partnerName: transaction.partnerDisplayName,
                            description: transaction.transactionDescription))) {
                    TransactionListItemView(bookingDate: formatter.string(from: transaction.bookingDate),
                                            partnerDisplayName: transaction.partnerDisplayName,
                                            transactionDescription: transaction.transactionDescription,
                                            amount: "\(transaction.amount)",
                                            currency: transaction.currency)
                }
            }
        }
        .overlay(content: {
            if items.isEmpty {
                EmptyView(message: "There is no transactions".localized)
            }
        })
        .toAnyView()
    }
}

struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView(store: Store(initialState: TransactionListReducer.State(), reducer: {
            TransactionListReducer()
        }))
    }
}
