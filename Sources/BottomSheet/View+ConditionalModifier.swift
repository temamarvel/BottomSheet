//
//  View+ConditionalModifier.swift
//  
//
//  Created by Артем Денисов on 24.09.2022.
//

import SwiftUI

extension View {
    @ViewBuilder func `if`(_ condition: @autoclosure () -> Bool, transform: (Self) -> some View) -> some View {
        if condition() {
            transform(self)
        } else {
            self
        }
    }
}
