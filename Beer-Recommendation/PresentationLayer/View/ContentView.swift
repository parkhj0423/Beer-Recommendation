//
//  ContentView.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/07/27.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel : BeerViewModel
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                ForEach(viewModel.beers) { beer in
                        
                    AsyncImage(url: URL(string: beer.imageUrl ?? ""))
                    
                    Text(beer.name ?? "없음")
                }
            }
            .task {
                do {
                    try await viewModel.getAllBeers()
                } catch {
                    print(error)
                }
            }
            
        }
        
            
    }
}
