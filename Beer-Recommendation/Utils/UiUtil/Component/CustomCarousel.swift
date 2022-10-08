//
//  CustomCarousel.swift
//  Beer-Recommendation
//
//  Created by 박현우 on 2022/10/08.
//

import SwiftUI

struct CustomCarousel<Content : View, Item : RandomAccessCollection, ID : Hashable>: View {
    
    var content : (Item.Element, CGSize) -> Content
    var id : KeyPath<Item.Element, ID>
    
    var spacing : CGFloat
    var cardPadding : CGFloat
    var items : Item
    @Binding var index : Int
    
    
    @State var currentIndex : Int = 0
    
    @GestureState var translation : CGFloat = 0
    @State var offset : CGFloat = 0
    @State var lastStoredOffset : CGFloat = 0
    
    init(
         id: KeyPath<Item.Element, ID>,
         spacing: CGFloat = 30,
         cardPadding: CGFloat = 80,
         items: Item,
         index: Binding<Int>,
         @ViewBuilder content: @escaping (Item.Element, CGSize) -> Content) {
        self.content = content
        self.id = id
        self.spacing = spacing
        self.cardPadding = cardPadding
        self.items = items
        self._index = index
             
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            
            let cardWidth = size.width - (cardPadding - spacing)
            LazyHStack(spacing : spacing) {
                ForEach(items, id: id) { item in
                    content(item, CGSize(width: size.width - cardPadding, height: size.height))
                        .frame(width: size.width - cardPadding, height: size.height)
                        .contentShape(Rectangle())
                }
            }
            .padding(.horizontal, spacing)
            .offset(x : limitScroll())
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 5)
                    .updating($translation, body: { value, out, _ in
                        out = value.translation.width
                    })
                    .onChanged{
                        onChanged(value: $0, cardWidth : cardWidth)
                    }
                    .onEnded{
                        onEnded(value: $0, cardWidth: cardWidth)
                    }
            )
        }
        .padding(.top, 60)
        .onAppear {
            let extraSpace = (cardPadding / 2) - spacing
            offset = extraSpace
            lastStoredOffset = extraSpace
        }
    }
    
    private func limitScroll() -> CGFloat {
        let extraSpace = (cardPadding / 2) - spacing
        
        if index == 0 && offset > extraSpace {
            return extraSpace + (offset / 4)
        } else if index == items.count - 1 && translation < 0 {
            return offset - (translation / 2)
        } else {
            return offset
        }
    }
    
    private func onChanged(value : DragGesture.Value, cardWidth : CGFloat) {
        let translationX = value.translation.width
        offset = translationX + lastStoredOffset
    }
    
    private func onEnded(value : DragGesture.Value, cardWidth : CGFloat) {
        var _index = (offset / cardWidth).rounded()
        _index = max(-CGFloat(items.count - 1), _index)
        _index = min(_index, 0)
        
        currentIndex = Int(_index)
        
        withAnimation(.easeInOut(duration: 0.25)) {
            // 공간 제거
            let extraSpace = (cardPadding / 2) - spacing
            offset = (cardWidth * _index) + extraSpace
        }
        
        lastStoredOffset = offset
    }
    
}
//
//struct CustomCarousel_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomCarousel()
//    }
//}
