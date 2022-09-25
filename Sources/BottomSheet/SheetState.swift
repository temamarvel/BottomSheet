//
//  SheetState.swift
//  
//
//  Created by Артем Денисов on 25.09.2022.
//

import SwiftUI

final internal class SheetState: ObservableObject{
    static let defaultSheetBackground = Color(.tertiarySystemBackground)
    static let defaultBackground = HierarchicalShapeStyle.secondary
    
    @Published var sheetBackground = AnyShapeStyle(defaultSheetBackground)
    @Published var background = AnyShapeStyle(defaultBackground)
}
