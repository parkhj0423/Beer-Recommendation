//
//  AsyncImageLoader.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/29.
//

import SwiftUI

struct AsyncImageLoader: View {
    
    var imageUrl : String?
    var width : CGFloat
    var height : CGFloat
    var isBlur : CGFloat? = 0
    var opacity : Bool? = false
    
    var body: some View {
        if let url = URL(string: imageUrl ?? "") {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: width, height : height, alignment: .center)
                    .blur(radius: isBlur != nil ? isBlur! : 0)
                    .background(Color.gray.opacity(opacity ?? false ? 0.1 : 0))
                    .cornerRadius(20)
            } placeholder: {
                ProgressView()
                    .frame(width: width, height : height, alignment: .center)
            }
        } else {
            Image(systemName: "questionmark.circle.fill")
                .frame(minWidth: 100, alignment: .center)
                .blur(radius: isBlur != nil ? isBlur! : 0)
        }
    }
}
