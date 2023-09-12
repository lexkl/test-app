//
//  Entities.swift
//  WorldOfPAYBACK
//
//  Created by Aleksey Klyonov on 11.09.2023.
//

import Foundation

enum Category: Int, CaseIterable, Identifiable {
    var id: Self { self }
    
    case all = 0
    case one = 1
    case two = 2
    case three = 3
}
