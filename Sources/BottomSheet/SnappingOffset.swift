//
//  SnappingOffset.swift
//  
//
//  Created by Артем Денисов on 18.09.2022.
//

import SwiftUI

final class SnappingOffset {
    static var top: CGFloat { SnappingOffset.padding }
    static var middle: CGFloat { UIScreen.main.bounds.height / 2 }
    static var bottom: CGFloat { UIScreen.main.bounds.height - padding}
    static var topMiddleDelta: CGFloat { (top + middle) / 2 }
    static var middleBottomDelta: CGFloat { (middle + bottom) / 2 }
    static private var padding: CGFloat { UIScreen.main.bounds.height / 10}
    
    static func getOpenOffset(_ openPosition: OpenLocation) -> CGFloat{
        switch openPosition {
            case .top:
                return SnappingOffset.top
            case .middle:
                return SnappingOffset.middle
            case .bottom:
                return SnappingOffset.bottom
        }
    }
}
