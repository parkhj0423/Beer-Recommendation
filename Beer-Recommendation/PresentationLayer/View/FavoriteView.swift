//
//  FavoriteView.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/21.
//

import SwiftUI

struct FavoriteView: View {
    
    @EnvironmentObject var sheetManager : SheetManager
    
    @State private var favoriteList : [BeerEntity] = []
    
    @State private var currentIndex : Int = 0
    
    var body: some View {
        VStack {
            CustomCarousel(id: \.id, cardPadding: 150, items: favoriteList, index: $currentIndex) { item, size in
                AsyncImageLoader(imageUrl: item.imageUrl, width: size.width, height: size.height)
                    .aspectRatio(contentMode: .fill)
//                    .clipShape(RoundedRectangle(cornerSize: 20, style: .continuous))
                    .contentShape(Rectangle())
            }
            .padding(.horizontal, -15)
        }
        .onAppear {
            self.favoriteList = PreferenceUtil().getFavoriteList()
        }
        
    }
    
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
