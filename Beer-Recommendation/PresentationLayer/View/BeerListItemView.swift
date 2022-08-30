//
//  BeerListItemView.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/27.
//

import SwiftUI

struct BeerListItemView: View {
    
    var item : BeerEntity
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            
            VStack(alignment : .leading, spacing : 10) {
                AsyncImageLoader(imageUrl: item.imageUrl, width: width, height: 175, opacity: true)
                
                descriptionView()
            }
        }
        .transaction { transaction in
            transaction.animation = nil
        }
        .frame(height: 250)
    }

    private func descriptionView() -> some View {
        VStack(alignment : .leading, spacing : 5) {
            Text(item.name ?? "")
                .font(.system(size: 16, weight: .bold))
            Text(item.tagline ?? "")
                .font(.system(size: 14, weight: .medium))
            Text(item.firstBrewed ?? "")
                .font(.system(size: 12, weight: .regular))
        }
    }
}
