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
    static private var topMiddleDelta: CGFloat { (top + middle) / 2 }
    static private var middleBottomDelta: CGFloat { (middle + bottom) / 2 }
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
    
    static func calculateOffset(openLocation: OpenLocation, offset: CGFloat, drarGestureValue value: DragGesture.Value) -> CGFloat{
        let currentOffset = SnappingOffset.getOpenOffset(openLocation) + offset + value.translation.height
        
        if currentOffset < SnappingOffset.topMiddleDelta {
            return SnappingOffset.top - SnappingOffset.getOpenOffset(openLocation)
        }
        if currentOffset > SnappingOffset.middleBottomDelta {
            return SnappingOffset.bottom - SnappingOffset.getOpenOffset(openLocation)
        }
        return SnappingOffset.middle - SnappingOffset.getOpenOffset(openLocation)
    }
}
