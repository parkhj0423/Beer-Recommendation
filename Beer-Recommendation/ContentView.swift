//
//  ContentView.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/07/27.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = BeerViewModel(useCase: BeerUseCase(repository: BeerRepository(dataSource: BeerDataSource())))
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                ForEach(viewModel.beers) { beer in
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
