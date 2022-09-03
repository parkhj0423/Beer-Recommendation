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
            let height = geometry.size.height
            ZStack(alignment : .top) {
                navigationBar()
                                
                headerImageView(descriptionHeight : height)
                
            }
        }
        
        .navigationBarHidden(true)
        .coordinateSpace(name: "SCROLL")
        .edgesIgnoringSafeArea(.bottom)
    }
    
    private func headerImageView(descriptionHeight : CGFloat) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            GeometryReader { geometry in
                let minY = geometry.frame(in: .named("SCROLL")).minY
                let width = geometry.size.width
                let height = geometry.size.height + minY
                
                VStack {
                    AsyncImageLoader(imageUrl: item.imageUrl, width: width, height: height < 200 ? 200 : height)
                        .aspectRatio(contentMode: .fill)
                        .offset(y : -minY)
                        .padding(.top , 30)
                    

                    detailView()
                        .frame(minHeight : descriptionHeight)
                }
                
            }
            .frame(minHeight : 300)
        }
    }
    
    
    private func detailView() -> some View {
        
        VStack {
            Rectangle()
                .fill(.white)
                .cornerRadius(30, corners: [.topLeft, .topRight])
                .overlay {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 20) {
                            Text(item.name ?? "")
                            Text(item.description ?? "")
                            Text(item.description ?? "")
                            
                            ForEach(item.foodPairing, id : \.self) { food in
                                Text(food)
                            }
                            
                            
                        }
                    }
                    .padding()
                }
                .foregroundColor(.black)
            
            
        }
        
        
    }
    
    private func navigationBar() -> some View {
        HStack {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark")
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .background(.white)
                    .clipShape(Circle())
                    .foregroundColor(.black)
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "suit.heart.fill")
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .background(.white)
                    .clipShape(Circle())
                    .foregroundColor(.red)
            }
        }
        .zIndex(2)
        .padding(.horizontal)
    }
    
}

