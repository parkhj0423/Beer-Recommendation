//
//  BeerDetailView.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/09/01.
//

import SwiftUI

struct BeerDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel : BeerViewModel
    var item : BeerEntity
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            VStack {
                    AsyncImageLoader(imageUrl: item.imageUrl, width: width, height: height / 2)
                
                    Rectangle()
                        .fill(.white)
                        .cornerRadius(20, corners: [.topLeft, .topRight])
                        .frame(width: width, height: height / 2)
                    
                    
                
            }
        }
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button {
//                    presentationMode.wrappedValue.dismiss()
//                } label: {
//                    Text("go back")
//                }
//            }
//        }
//        .navigationBarBackButtonHidden(true)
    }
}

