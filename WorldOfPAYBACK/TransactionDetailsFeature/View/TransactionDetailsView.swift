//
//  TransactionDetailsView.swift
//  WorldOfPAYBACK
//
//  Created by Aleksey Klyonov on 11.09.2023.
//

import SwiftUI
import ComposableArchitecture

struct TransactionDetailsView: View {
    let store: StoreOf<TransactionDetailsReducer>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            Form {
                Text(viewStore.transaction.partnerName)
                Text(viewStore.transaction.description)
            }
        }
    }
}

struct TransactionDetailsView_Previews: PreviewProvider {
    private static var details = TransactionDetails(partnerName: "Name",
                                                    description: "Description")
    static var previews: some View {
        TransactionDetailsView(store: Store(initialState: TransactionDetailsReducer.State(transaction: details), reducer: {
            TransactionDetailsReducer()
        }))
    }
}
