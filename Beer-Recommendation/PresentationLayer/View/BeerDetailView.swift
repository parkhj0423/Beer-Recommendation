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
    
    @StateObject var scrollViewUtil : ScrollViewUtil
    @ObservedObject var viewModel : BeerViewModel
    var item : BeerEntity
    
    @State private var showNavigationTitle : Bool = false
    
    init(viewModel : BeerViewModel, item : BeerEntity) {
        self.viewModel = viewModel
        self.item = item
        self._scrollViewUtil = StateObject.init(wrappedValue: ScrollViewUtil())
    }
    
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
                .frame(minHeight : descriptionHeight - 100)
        }
        .introspectScrollView { scrollView in
            scrollViewUtil.isBottomBounceDisable = true
            scrollView.delegate = scrollViewUtil
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
                                
                                summaryView()
                                
                                descriptionView(title: "Description", content: item.description ?? "")
                                
                                descriptionView(title: "Brewers Tips", content: item.brewersTips ?? "")
                                
                                foodPairingView()
                                
                                descriptionView(title: "Yeast", content: item.ingredients?.yeast ?? "")
                                
                                hopView()
                                
                                maltView()
                                
                                descriptionView(title: "Contributed By", content: item.contributedBy ?? "")
                                
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 50, trailing: 20))
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
    
    private func summaryView() -> some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(.ultraThickMaterial)
            .frame(height: 80)
            .overlay {
                HStack(spacing : 50) {
                    bitterSummaryView()
                    
                    alcoholPercentView()
                    
                    phView()
                }
            }
    }
    
    private func bitterSummaryView() -> some View {
        VStack(spacing : 0) {
            Image("bitter")
                .resizable()
                .frame(width: 45, height: 45)

            if let ibu = item.ibu {
                if ibu >= 70 {
                    Text("very")
                } else if ibu >= 50 {
                    Text("little")
                } else {
                    Text("normal")
                }
            }
            
        }
        .font(.system(size: 16, weight: .bold))
    }
    
    private func alcoholPercentView() -> some View {
        VStack(spacing : 0) {
            Image("alcohol_percent")
                .resizable()
                .frame(width: 45, height: 45)
            
            Text("\(String(format: "%.1f", item.abv ?? 0))%")
        }
        .font(.system(size: 16, weight: .bold))
    }
    
    private func phView() -> some View {
        VStack(spacing : 0) {
            Image("brewing")
                .resizable()
                .frame(width: 45, height: 45)
            
            Text("\(String(format: "%.1f", item.ph ?? 0))")
        }
        .font(.system(size: 16, weight: .bold))
    }
    
    private func foodPairingView() -> some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Food Pairng")
                .font(.system(size: 17, weight: .bold))
            
            ForEach(item.foodPairing, id : \.self) { food in
                Text(food)
            }
            .font(.system(size: 13, weight: .regular))
        }
    }
    
    private func hopView() -> some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Hops")
                .font(.system(size: 17, weight: .bold))
            
            if let hops = item.ingredients?.hops {
                ForEach(hops) { hop in
                    Divider()
                    HStack(spacing : 10) {
                        Image("hop")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text(hop.name ?? "")
                        Text("/")
                        Text(hop.attribute ?? "")
                        Text("/")
                        Text(hop.add ?? "")
                    }
                }
                .font(.system(size: 13, weight: .medium))
            }
        }
    }
    
    private func maltView() -> some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Malts")
                .font(.system(size: 17, weight: .bold))
            
            if let malts = item.ingredients?.malt {
                ForEach(malts) { malt in
                    Divider()
                    HStack(spacing : 10) {
                        Image("malt")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text(malt.name ?? "")
                        Text("/")
                        Text("\(String(format: "%.1f", malt.amount?.value ?? 0))")
                        Text("/")
                        Text(malt.amount?.unit ?? "")
                    }
                }
                .font(.system(size: 13, weight: .medium))
            }
        }
    }
    
}

