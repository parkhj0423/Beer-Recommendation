//
//  BeerDetailView.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/09/01.
//

import SwiftUI
import Introspect

struct BeerDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel : BeerViewModel
    var item : BeerEntity
    
    @State private var showNavigationTitle : Bool = false
    
    
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
                
                VStack {
                    ZStack(alignment : .bottomLeading) {
                        AsyncImageLoader(imageUrl: item.imageUrl, width: width, height: minY > 0 ? minY + 250 : 250)
                            .aspectRatio(contentMode: .fill)
                            .offset(y : -minY)
                            .padding(.top , 30)
                        
                        if !self.showNavigationTitle {
                            titleView()
                        }
                    }
                }
                .onChange(of: minY) {
                    if $0 < -115 {
                        self.showNavigationTitle = true
                    } else {
                        self.showNavigationTitle = false
                    }
                }
            }
            .frame(minHeight : 300)
            
            detailView()
                .frame(minHeight : descriptionHeight - 50)
        }
    }
    
    
    private func detailView() -> some View {
        VStack {
            Rectangle()
                .fill(.regularMaterial)
                .cornerRadius(30, corners: [.topLeft, .topRight])
                .overlay {
                    VStack(alignment: .center, spacing: 10) {
                        holderView()
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(alignment: .leading, spacing: 20) {
                                
                                //MARK: 네모난 영역에 3가지 대표 정보 ex. 씀 정도, 흑맥주인지 아닌지 등등
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(.ultraThickMaterial)
                                    .frame(height: 80)
                                    .overlay {
                                        if viewModel.getStarCount(beer: item) > 5 {
                                            Text("very bitter")
                                        } else if viewModel.getStarCount(beer: item) > 3 {
                                            Text("little bit")
                                        } else {
                                            Text("not bitter")
                                        }
                                    }
                                
                                descriptionView(title: "Description", content: item.description ?? "")
                                
                                descriptionView(title: "Brewers Tips", content: item.brewersTips ?? "")
                                
                                descriptionView(title: "Contributed By", content: item.contributedBy ?? "")
                                
                                ForEach(item.foodPairing, id : \.self) { food in
                                    Text(food)
                                }
                                

                                
                                
                            }
                        }
                        .zIndex(3)
                    }
                    .padding()
                }
        }
    }
    
    private func navigationBar() -> some View {
        HStack {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "arrow.backward")
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .background(.white)
                    .clipShape(Circle())
                    .foregroundColor(.black)
            }
            
            if self.showNavigationTitle {
                navigationTitleView()
            } else {
                Spacer()
            }
            
            Button {
                
            } label: {
                Image(systemName: "suit.heart.fill")
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .background(.white)
                    .clipShape(Circle())
                    .foregroundColor(.red)
            }
        }
        .frame(height : 50)
        .zIndex(2)
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func navigationTitleView() -> some View {
        Spacer()
        Text(item.name ?? "")
            .font(.system(size: 20, weight: .bold))
            .frame(maxWidth : 200)
        Spacer()
    }
    
    private func titleView() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            bitterRecognizeView()
            
            Text(item.name ?? "")
                .font(.title)
                .bold()
            
            VStack(alignment : .leading, spacing : 5) {
                Text(item.tagline ?? "")
                    .font(.headline)
                
                Text(item.firstBrewed ?? "")
                    .font(.subheadline)
                
            }
        }
        .padding(.leading, 20)
    }
    
    private func bitterRecognizeView() -> some View {
        HStack(spacing : 10) {
            ForEach(0..<viewModel.getStarCount(beer: item), id : \.self) { _ in
                Image(systemName: "star.fill")
                    .resizable()
                    .foregroundColor(.yellow)
                    .frame(width: 20, height: 20)
            }
        }
    }
    
    private func descriptionView(title : String, content : String) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(title)
                .font(.system(size: 17, weight: .bold))
            
            Text(content)
                .font(.system(size: 13, weight: .regular))
        }
    }
        
    private func holderView() -> some View {
        RoundedRectangle(cornerRadius: 50)
            .fill(.gray)
            .frame(width: 70, height: 7)
    }
    
    
}

