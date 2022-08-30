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
                
                recommendView()
                
                VStack(alignment : .center, spacing : 0) {
                    
                    categoryView()
                    
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
                BeerRecommendView(item: randomBeer)
            }
        }
    }
    
    private func categoryView() -> some View {
        Text("category view will show here")
    }
    
    private func beerListView() -> some View {
        LazyVGrid(columns: itemLayout, alignment: .leading, spacing: 8) {
            ForEach(viewModel.beers.indices, id : \.self) { index in
                BeerListItemView(item: viewModel.beers[index])
                    .padding(.top, index % 2 == 0 ? 0 : 70)
                    .onTapGesture {
                        // go to detail view
                    }
            }
        }
        .padding(.bottom, 70)
    }
}
