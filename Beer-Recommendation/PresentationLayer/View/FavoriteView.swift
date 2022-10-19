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
        ZStack {
            BlurBackgroundView()
            
            CustomCarousel(id: \.id, cardPadding: 170, items: viewModel.favoriteList, index: $currentIndex) { item, size in
                ZStack {
                    
                    VStack(spacing : 20) {
                        AsyncImageLoader(imageUrl: item.imageUrl, width: size.width, height: 500)
                            .aspectRatio(contentMode: .fill)
                            
                        Text(item.name ?? "")
                            .font(.system(size: 20, weight: .bold))
                        
                        
                    }
                    .padding(.bottom, 20)
                   
                }
                
            }
            .padding(.horizontal, -15)
        }
        .ignoresSafeArea()
        .onAppear {
            viewModel.getFavoriteList()
        }
        
    }
    
}

