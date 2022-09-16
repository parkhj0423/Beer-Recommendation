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
    
    let itemLayout : [GridItem] = [
        GridItem(.flexible(minimum: 150)),
        GridItem(.flexible(minimum: 150))
    ]
    
    var body: some View {
        VStack(spacing : 20) {
            ScrollViewReader { proxy in
                ScrollView(showsIndicators: false) {
                    searchView()
                        .onAppear {
                            proxy.scrollTo("top")
                        }
                    
                    if !viewModel.isSearched() {
                        recommendView()
                    }
                    
                    LazyVStack(alignment : .leading, spacing : 0) {
                        beerListView()
                    }
                    .padding()
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
            Text("Today's Beer!!!")
                .bold()
                .font(.title)
            
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
        ScrollView(.horizontal,showsIndicators: false) {
            HStack {
               
                    Button {
                       
                    } label : {
                        Text("category")
                            .font(.system(size: 12))
                            .fontWeight(.regular)
                            .frame(minHeight: 33)
                            .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
                            .foregroundColor(.black)
                            .background(.white)
                            .cornerRadius(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.black, lineWidth: 1)
                            )
                    }
                
                
            }
        }
    }
    
    
    @ViewBuilder
    private func beerListView() -> some View {
        if !viewModel.isSearched() {
            categoryView()
        } else {
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
                    if viewModel.isLastItem(index: index) {
                        try? await viewModel.getBeersWithPaging()
                    }
                }
            }
        }
        .padding(.bottom, 70)
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
