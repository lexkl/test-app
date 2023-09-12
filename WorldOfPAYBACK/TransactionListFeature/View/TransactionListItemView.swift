//
//  TransactionListItemView.swift
//  WorldOfPAYBACK
//
//  Created by Aleksey Klyonov on 10.09.2023.
//

import SwiftUI

struct PBTransaction: Identifiable, Equatable {
    let id = UUID()
    
    let bookingDate: Date
    let partnerDisplayName: String
    let transactionDescription: String
    let amount: Int
    let currency: String
    let category: Int
}

struct TransactionListItemView: View {
    let bookingDate: String
    let partnerDisplayName: String
    let transactionDescription: String
    let amount: String
    let currency: String
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 5) {
                Text(partnerDisplayName)
                    .font(.system(size: 15, weight: .bold))
                Text(transactionDescription)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                Text(bookingDate)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
            Spacer()
            HStack(spacing: 3) {
                Text(amount)
                    .font(.system(size: 15))
                Text(currency)
                    .font(.system(size: 15))
            }
        }
    }
}

struct TransactionListItemView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListItemView(bookingDate: "bookingDate",
                                partnerDisplayName: "partnerDisplayName",
                                transactionDescription: "transactionDescription",
                                amount: "amount",
                                currency: "currency")
    }
}
