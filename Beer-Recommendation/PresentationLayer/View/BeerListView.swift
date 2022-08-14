//
//  BeerListView.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/07/27.
//

import SwiftUI

struct BeerListView: View {
    @StateObject var viewModel : BeerViewModel
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                ForEach(viewModel.beers) { beer in
                    if let url = URL(string: beer.imageUrl ?? "") {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width : 100, height : 200)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    
                    Text(beer.name ?? "없음")
                        .font(.system(size: 20, weight: .bold))
                }
            }
            .task() {
                try? await viewModel.getAllBeers()
            }
        }
        .showLoadingView(isLoading: viewModel.isLoading)   
    }
}
