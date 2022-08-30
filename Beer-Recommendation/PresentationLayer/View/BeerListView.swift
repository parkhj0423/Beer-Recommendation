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
    
    let itemLayout : [GridItem] = [
        GridItem(.flexible(minimum: 150)),
        GridItem(.flexible(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                searchView()
                
                if !viewModel.isSearched() {
                    recommendView()
                }
                
                VStack(alignment : .leading, spacing : 0) {
                    beerListView()
                }
                .padding()
            }
            
        }
        .task {
            try? await viewModel.getAllBeers()
            try? await viewModel.getRandomBeer()
        }
        .navigationBarColor(backgroundColor: UIColor.clear, shadowColor: UIColor.clear)
        .showSheet(sheetManager: sheetManager)
        .showErrorModal(error: $viewModel.viewModelError, onDismiss: { viewModel.cleanError() })
        .showLoadingView(isLoading: viewModel.isLoading)
        
    }
    
    private func searchView() -> some View {
        CustomTextField(text: $viewModel.searchKeyword)
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
        Text("category view will show here")
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
                BeerListItemView(item: viewModel.isSearched() ? viewModel.searchedBeers[index] : viewModel.beers[index])
                    .padding(.top, index % 2 == 0 ? 0 : 70)
                    .onTapGesture {
                        // go to detail view
                    }
                
            }
        }
        .padding(.bottom, 70)
    }
    
    private func moveToDetailButton() -> some View {
        Button {
            
        } label: {
            RoundedRectangle(cornerRadius: 35)
                .fill(Color.white)
                .frame(width: 60, height: 35)
                .overlay {
                    Image(systemName: "arrow.forward")
                        .foregroundColor(Color.black)
                }
        }
        .padding(.trailing, 20)
    }
}
