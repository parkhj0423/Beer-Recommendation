//
//  BeerRecommendView.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/28.
//

import SwiftUI

struct BeerRecommendView: View {
    
    var item : BeerEntity
    
    var body: some View {
        GeometryReader { geometry in
            let width : CGFloat = geometry.size.width
            
            ZStack {
                AsyncImageLoader(imageUrl: item.imageUrl, width: width, height: 300, isBlur: 4)

                descriptionView()
            }
                
        }
        .frame(height: 350)
    }

    
    private func descriptionView() -> some View {
        HStack(spacing : 10) {
            AsyncImageLoader(imageUrl: item.imageUrl, width: 100, height: 200)
            
            VStack(alignment : .leading , spacing: 10) {
                Text(item.name ?? "")
                    .font(.title)
                    .bold()
                Text(item.tagline ?? "")
                    .font(.body)
                Text("ph : \(String(format: "%.1f", item.ph ?? 0))")
                Text("abv : \(String(format: "%.1f", item.abv ?? 0))%")
                Text("Attenuation Level : \(String(format: "%.1f", item.attenuationLevel ?? 0))")
                Text(item.firstBrewed ?? "")
            }
            .font(.caption)
            .font(.system(size: 15, weight: .bold))
        }
        .frame(alignment : .leading)
    }
}
