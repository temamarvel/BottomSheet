//
//  DragCapsule.swift
//
//  Created by Артем Денисов on 04.07.2022.
//

import SwiftUI

public struct DragCapsule: View {
    let width: CGFloat
    let height: CGFloat
    
    init(width: CGFloat = 50, height: CGFloat = 8) {
        self.width = width
        self.height = height
    }
    
    public var body: some View {
        Capsule()
            .fill(Color(.tertiarySystemFill))
            .frame(width: width, height: height)
    }
}

struct DragCapsule_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20){
            DragCapsule()
            DragCapsule(width: 100, height: 10)
            DragCapsule(width: 10, height: 100)
            DragCapsule(width: 100, height: 100)
        }
    }
}
