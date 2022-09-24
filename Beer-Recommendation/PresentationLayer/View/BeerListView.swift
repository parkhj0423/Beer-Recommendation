//
//  BeerListView.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/07/27.
//

import SwiftUI

struct BeerListView: View {
    @EnvironmentObject var sheetManager : SheetManager
    
    @StateObject var viewModel : BeerViewModel
    var toggleTabView : () -> ()
    
    @State private var topOffset : CGFloat = 0
    
    let itemLayout : [GridItem] = [
        GridItem(.flexible(minimum: 150)),
        GridItem(.flexible(minimum: 150))
    ]
    
    var body: some View {
        VStack(spacing : 20) {
            ScrollViewReader { proxy in
                ZStack(alignment : .top) {
                    
//                    if self.topOffset < 0 {
//                        let scenes = UIApplication.shared.connectedScenes
//                        let windowScene = scenes.first as? UIWindowScene
//                        let window = windowScene?.windows.first
//
//                        categoryView()
//                            .background(
//                                BlurBackgroundView()
//                                    .frame(height : (window?.safeAreaInsets.top ?? 0) + 80)
//                                    .edgesIgnoringSafeArea(.top)
//                            )
//
//
//                    }
                    
                    ScrollView {
                        searchView()
                            .onAppear {
                                proxy.scrollTo("top")
                            }
                        
                        if !viewModel.isSearched() {
                            recommendView()
                        }
                        
                        categoryView()
                        
                        LazyVStack(alignment : .leading, spacing : 0) {
                            beerListView()
                        }
                        
                    }
                }
                
            }
        }
        .onAppear {
            toggleTabView()
        }
        .onDisappear {
            toggleTabView()
        }
        .showSheet(sheetManager: sheetManager)
        .showErrorModal(error: $viewModel.viewModelError, onDismiss: { viewModel.cleanError() })
        .showLoadingView(isLoading: viewModel.isLoading)
        .task {
            try? await viewModel.getBeersWithPaging(page: 1)
            try? await viewModel.getRandomBeer()
        }
        
    }
    
    private func searchView() -> some View {
        CustomTextField(text: $viewModel.searchKeyword)
            .id("top")
    }
    
    private func recommendView() -> some View {
        VStack(alignment : .leading) {
            
            if let randomBeer = viewModel.randomBeer.first {
                ZStack(alignment: .bottomTrailing) {
                    BeerRecommendView(item: randomBeer)
                    
                    moveToDetailButton()
                }
            }
        }
        .padding([.leading, .trailing], 10)
    }
    
    private func categoryView() -> some View {
        GeometryReader { geometry in
            let minY = geometry.frame(in: .global).minY
            ScrollView(.horizontal,showsIndicators: false) {
                HStack {
                    ForEach(Category.allCases, id :\.rawValue) { category in
                        Button {
                            Task {
                                viewModel.setCategory(category: category)
                                if category == .all {
                                    try? await viewModel.getBeersWithPaging()
                                } else {
                                    try? await viewModel.getBeersByCategory()
                                }
                            }
                        } label : {
                            Text(category.rawValue)
                                .font(.system(size: 15))
                                .fontWeight(viewModel.selectedCategory == category ? .medium : .regular)
                                .frame(minHeight: 36)
                                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                                .foregroundColor(viewModel.selectedCategory == category ? .black : .white)
                                .background(viewModel.selectedCategory == category ? .white : .gray)
                                .cornerRadius(16)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(.black, lineWidth: 1)
                                )
                        }
                    }
                }
            }
            .onChange(of: minY) { offset in
                self.topOffset = offset - 80
            }
            .offset(y : self.topOffset < 0 ? -self.topOffset : 0)
        }
        .zIndex(5)
    }
    
    
    @ViewBuilder
    private func beerListView() -> some View {
        if viewModel.isSearched() {
            Text("\(viewModel.searchedBeers.count) items have been searched")
                .bold()
                .font(.title3)
        }
        
        LazyVGrid(columns: itemLayout, alignment: .leading, spacing: 8) {
            ForEach(viewModel.isSearched() ? viewModel.searchedBeers.indices : viewModel.beers.indices, id : \.self) { index in
                let item = viewModel.isSearched() ? viewModel.searchedBeers[index] : viewModel.beers[index]
                
                NavigationLink {
                    BeerDetailView(viewModel: viewModel, item: item)
                } label: {
                    BeerListItemView(item: item)
                        .padding(.top, index % 2 == 0 ? 0 : 70)
                }
                .task {
                    if viewModel.isLastItem(index: index), viewModel.selectedCategory == .all {
                        try? await viewModel.getBeersWithPaging()
                    }
                }
            }
        }
        
        .padding(.bottom, 50)
    }
    
    @ViewBuilder
    private func moveToDetailButton() -> some View {
        if let recommendBeer = viewModel.randomBeer.first {
            NavigationLink {
                BeerDetailView(viewModel: viewModel, item: recommendBeer)
            } label: {
                RoundedRectangle(cornerRadius: 35)
                    .fill(Color.white)
                    .frame(width: 60, height: 35)
                    .overlay {
                        Image(systemName: "arrow.forward")
                            .foregroundColor(Color.black)
                    }
                    .padding(.trailing, 20)
            }
        }
    }
}
