//
//  ViewExtensions.swift
//  WorldOfPAYBACK
//
//  Created by Aleksey Klyonov on 10.09.2023.
//

import Foundation
import SwiftUI

extension View {
    func toAnyView() -> AnyView {
        AnyView(self)
    }
}
