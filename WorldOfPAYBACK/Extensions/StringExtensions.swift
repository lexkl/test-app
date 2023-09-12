//
//  StringExtensions.swift
//  WorldOfPAYBACK
//
//  Created by Aleksey Klyonov on 12.09.2023.
//

import Foundation

extension String {
    var localized: Self {
         NSLocalizedString(self, comment: "")
    }
}
