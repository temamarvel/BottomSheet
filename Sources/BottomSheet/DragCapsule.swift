//
//  DragCapsule.swift
//
//  Created by Артем Денисов on 04.07.2022.
//

import SwiftUI

struct DragCapsule: View {
    var body: some View {
        Capsule()
            .fill(Color(.tertiarySystemFill))
            .frame(width: 50, height: 8)
            .padding()
    }
}

struct DragCapsule_Previews: PreviewProvider {
    static var previews: some View {
        DragCapsule()
    }
}
