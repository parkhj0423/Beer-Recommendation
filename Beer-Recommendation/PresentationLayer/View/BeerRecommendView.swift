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
                thumbnailImageView(width: width)

                descriptionView()
            }
                
        }
        .frame(height: 350)
    }
    
    @ViewBuilder
    private func thumbnailImageView(width : CGFloat) -> some View {
        if let url = URL(string: item.imageUrl ?? "") {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: width, height : 300, alignment: .center)
                    .blur(radius: 4)
                    .cornerRadius(20)
            } placeholder: {
                ProgressView()
                    .frame(width: width, height : 300, alignment: .center)
            }
        }
    }
    
    private func descriptionView() -> some View {
        HStack(spacing : 10) {
            if let url = URL(string: item.imageUrl ?? "") {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height : 200, alignment: .center)
                        .cornerRadius(20)
                } placeholder: {
                    ProgressView()
                        .frame(width: 100, height : 200, alignment: .center)
                }
            }
            
            VStack(alignment : .leading , spacing: 10) {
                Text(item.name ?? "")
                Text(item.tagline ?? "")
                Text(item.firstBrewed ?? "")
            }
            .font(.system(size: 18, weight: .bold))
            
        }
    }
}
