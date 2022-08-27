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
                if let url = URL(string: item.imageUrl ?? "") {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: width, height : 175, alignment: .center)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(20)
                    } placeholder: {
                        ProgressView()
                            .frame(width: width, height : 175, alignment: .center)
                    }
                }
                
                descriptionView()
            }
        }
        .frame(height: 250)
    }
    
    private func descriptionView() -> some View {
        VStack(alignment : .leading, spacing : 5) {
            if let name = item.name {
                Text(name)
            }
            
            if let tagline = item.tagline {
                Text(tagline)
            }
            
            if let firstBrewed = item.firstBrewed {
                Text(firstBrewed)
            }
        }
        .font(.system(size: 14, weight: .bold))
    }
}
