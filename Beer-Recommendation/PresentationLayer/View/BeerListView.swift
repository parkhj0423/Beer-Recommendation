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
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                Button {
                    sheetManager.changeSheet(type: .regularSheet, sheet: .comment)
                } label: {
                    Text("show RegularSheet")
                }
                Button {
                    sheetManager.changeSheet(type: .fullScreenSheet, sheet: .comment)
                } label: {
                    Text("show FullScreenSheet")
                }

                Button {
                    sheetManager.changeSheet(type: .bottomSheet, sheet: .comment)
                } label: {
                    Text("show BottomSheet")
                }
                
                Button {
                    sheetManager.changeSheet(type: .miniSheet, sheet: .comment)
                } label: {
                    Text("show MiniSheet")
                }
                
                Text(viewModel.randomBeer.first?.name ?? "")
                Divider()
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
                try? await viewModel.getRandomBeer()
            }
        }
        .showModal(sheetManager: sheetManager)
        .showErrorModal(error: $viewModel.viewModelError, onDismiss: { viewModel.cleanError() })
        .showLoadingView(isLoading: viewModel.isLoading)   
    }
}
