//
//  EmptyView.swift
//  WorldOfPAYBACK
//
//  Created by Aleksey Klyonov on 10.09.2023.
//

import SwiftUI

struct EmptyView: View {
    let message: String
    
    var body: some View {
        VStack {
            Text(message)
                .foregroundColor(.gray)
        }
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView(message: "EmptyView")
    }
}
