//
//  CustomCarousel.swift
//  Beer-Recommendation
//
//  Created by 박현우 on 2022/10/08.
//

import SwiftUI

struct CustomCarousel<Content : View, Item ,ID >: View where Item : RandomAccessCollection, ID : Hashable , Item.Element : Equatable {
    
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
    
    @State var rotation : Double = 0
    
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
                    
                    let index = indexOf(item: item)
                    
                    content(item, CGSize(width: size.width - cardPadding, height: size.height))
                        // 5도 만큼 각 item을 회전
//                        .rotationEffect(.init(degrees: Double(index) * 5), anchor: .bottom)
//                        .rotationEffect(.init(degrees: rotation), anchor: .bottom)
                        // 부드러운 애니메이션을 위한 offset
                        .offset(y : offsetY(index: index, cardWidth: cardWidth))
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
        .animation(.easeOut, value: translation == 0)
    }
    
    private func offsetY(index : Int, cardWidth : CGFloat) -> CGFloat {
        let progress = ((translation < 0 ? translation : -translation) / cardWidth) * 60
        let yOffset = -progress < 60 ? progress : -(progress + 120)
        
        let previous = (index - 1) == self.index ? (translation < 0 ? yOffset : -yOffset) : 0
        let next = (index + 1) == self.index ? (translation < 0 ? -yOffset : yOffset) : 0
        let In_Between = (index - 1) == self.index ? previous : next
        
        return index == self.index ? -60 - yOffset : In_Between
    }
    
    private func indexOf(item : Item.Element) -> Int {
        let array = Array(items)
        if let index = array.firstIndex(of: item) {
            return index
        }
        return 0
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
        
        let progress = offset / cardWidth
        rotation = (progress * 5).rounded() - 1
    }
    
    private func onEnded(value : DragGesture.Value, cardWidth : CGFloat) {
        var _index = (offset / cardWidth).rounded()
        _index = max(-CGFloat(items.count - 1), _index)
        _index = min(_index, 0)
        
        currentIndex = Int(_index)
        index = -currentIndex
        withAnimation(.easeInOut(duration: 0.25)) {
            // 공간 제거
            let extraSpace = (cardPadding / 2) - spacing
            offset = (cardWidth * _index) + extraSpace
        }
        
        lastStoredOffset = offset
    }
    
}
