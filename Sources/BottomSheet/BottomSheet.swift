//
//  BottomSheet.swift
//
//  Created by Артем Денисов on 01.07.2022.
//

import SwiftUI

public struct BottomSheet<Content>: View where Content: View {
    @GestureState private var dragTranslation: CGFloat = 0
    //важное знание: если проперть передана через биндинг, тогда ее значение меняется только во view в которой она использется не пересоздается (не зовется инициалайзер), но перересовывается (redraw)
    @Binding private var isOpen: Bool
    @State private var offset = CGFloat.zero
    
    let openLocation: OpenLocation
    let content: Content
    
    public init(isOpen: Binding<Bool>, openLocation: OpenLocation = .middle, @ViewBuilder content: () -> Content) {
        self._isOpen = isOpen
        self.openLocation = openLocation
        self.content = content()
    }
    
    public var body: some View {
        GeometryReader{ _ in
            VStack(){
                DragCapsule()
                self.content
            }
            .onChange(of: isOpen){ newValue in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    if !newValue {
                        offset = .zero
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width,
                   height: UIScreen.main.bounds.height * 2,
                   alignment: .top)
            
            .background(Color(.secondarySystemBackground))
            .cornerRadius(40)
            .offset(y: isOpen ? SnappingOffset.getOpenOffset(openLocation) : UIScreen.main.bounds.height)
            .offset(y: dragTranslation)
            .offset(y: offset)
            .gesture(DragGesture()
                .updating($dragTranslation){ value, gestureState, transaction in gestureState = value.translation.height }
                .onEnded{ value in offset = SnappingOffset.calculateOffset(openLocation: openLocation, offset: offset, drarGestureValue: value) }
            )
            .animation(.spring(), value: isOpen)
            .animation(.spring(), value: dragTranslation)
            //бекграунд полностью перехватывает тапы
            //так можно делать только если не нужна интерактивность с пользоавтелем
            //.background(.ultraThinMaterial).opacity(0.2)
        }.edgesIgnoringSafeArea(.all)
    }
}

struct BottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheet(isOpen: .constant(true), openLocation: .middle){
            VStack{
                Text("Test text 123")
                Text("Hello world")
                Spacer()
            }
            .frame(width: 200, height: 400)
            .background(.red)
        }
    }
}
