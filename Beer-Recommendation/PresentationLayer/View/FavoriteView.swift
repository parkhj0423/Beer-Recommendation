//
//  FavoriteView.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/21.
//

import SwiftUI

struct FavoriteView: View {
    
    @EnvironmentObject var sheetManager : SheetManager
    @StateObject var viewModel : FavoriteViewModel
    
    @State private var currentIndex : Int = 0
    
    var body: some View {
        VStack {
            CustomCarousel(id: \.id, cardPadding: 150, items: viewModel.favoriteList, index: $currentIndex) { item, size in
                ZStack {
                    BlurBackgroundView()
                    
                    AsyncImageLoader(imageUrl: item.imageUrl, width: size.width, height: 500)
                        .aspectRatio(contentMode: .fill)
                        .overlay {
                            Text(item.name ?? "")
                        }
                }
                
                
            }
            .padding(.horizontal, -15)
        }
        .onAppear {
            viewModel.getFavoriteList()
        }
        
    }
    
}

