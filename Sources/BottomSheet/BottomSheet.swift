//
//  BottomSheet.swift
//
//  Created by Артем Денисов on 01.07.2022.
//

import SwiftUI

public struct BottomSheet<Content>: View where Content: View {
    @ObservedObject var state = SheetState()
    
    @GestureState private var dragTranslation = CGFloat.zero
    @Binding private var isOpen: Bool
    @State private var dragOffset = CGFloat.zero
    
    private var offset: CGFloat { SnappingOffset.getOpenOffset(openLocation) + dragTranslation + dragOffset }
    
    let openLocation: OpenLocation
    let content: Content
    let showBackground: Bool
    let showCloseButton: Bool
    
    public init(isOpen: Binding<Bool>, openLocation: OpenLocation = .middle, showCloseButton: Bool = false, showBackground: Bool = true, @ViewBuilder content: () -> Content) {
        self._isOpen = isOpen
        self.openLocation = openLocation
        self.showCloseButton = showCloseButton
        self.showBackground = showBackground
        self.content = content()
    }
    
    public var body: some View {
        GeometryReader{ geometry in
            ZStack(alignment: .top){
                VStack(){
                    DragCapsule().padding()
                    self.content
                }
                if(showCloseButton){
                    Button { isOpen.toggle() } label: {
                        Image(systemName: "x.circle.fill")
                            .font(.title)
                            .foregroundColor(Color.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding()
                }
            }
            .onChange(of: isOpen){ newValue in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    if !newValue {
                        dragOffset = .zero
                    }
                }
            }
            .frame(width: geometry.size.width,
                   height: geometry.size.height * 2,
                   alignment: .top)
            .background(state.sheetBackground)
            .cornerRadius(20)
            .shadow(color: Color(.systemGray4), radius: 4)
            .offset(y: isOpen ? offset : UIScreen.main.bounds.height)
            .gesture(DragGesture()
                .updating($dragTranslation){ value, gestureState, transaction in gestureState = value.translation.height }
                .onEnded{ value in dragOffset = SnappingOffset.calculateDragOffset(openLocation: openLocation, dragOffset: dragOffset, dragTranslation: value.translation.height) }
            )
            .animation(.spring(), value: isOpen)
            .animation(.spring(), value: dragTranslation)
        }
        .if(showBackground){
            view in view.background(state.background.opacity(isOpen ? calculateBackgroundOpacity(offset: offset, maxOpacity: 0.5) : 0))
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    func calculateBackgroundOpacity(offset currentOffset: CGFloat, maxOpacity: CGFloat) -> CGFloat {
        let maxOffset = SnappingOffset.middle
        let minOffset = SnappingOffset.top
        let delta = maxOffset - currentOffset
        let k = delta / ((maxOffset - minOffset) / (maxOpacity * 10))
        return 0.1 * k
    }
    
    func sheetBackground(_ sheetBackground: any ShapeStyle) -> BottomSheet{
        self.state.sheetBackground = AnyShapeStyle(sheetBackground)
        return self
    }
    
    func background(_ background: any ShapeStyle) -> BottomSheet{
        self.state.background = AnyShapeStyle(background)
        return self
    }
}

struct BottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Rectangle().frame(width: 100, height: 100)
            BottomSheet(isOpen: .constant(true), openLocation: .middle, showCloseButton: true){
                VStack{
                    Text("Test text 123")
                    Text("Hello world")
                    Spacer()
                }
                .frame(width: 200, height: 400)
                .background(.red)
            }
            .sheetBackground(.green)
            .background(.red)
        }.background(.yellow)
    }
}
