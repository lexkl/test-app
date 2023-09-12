//
//  WorldOfPAYBACKApp.swift
//  WorldOfPAYBACK
//
//  Created by Aleksey Klyonov on 09.09.2023.
//

import SwiftUI
import ComposableArchitecture

@main
struct WorldOfPAYBACKApp: App {
    var body: some Scene {
        WindowGroup {
            TransactionListView(store: Store(initialState: TransactionListReducer.State(), reducer: {
                TransactionListReducer()
                    ._printChanges()
            }))
        }
    }
}
