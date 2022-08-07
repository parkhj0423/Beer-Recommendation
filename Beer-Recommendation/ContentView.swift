//
//  ContentView.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/07/27.
//

import SwiftUI

struct ContentView: View {
    var viewModel = BeerDataSource()
    
    var body: some View {
        VStack {
            Text("Beer!")
                .padding()
        }
        .task  {
            do {
                let data = try await viewModel.getRandomBeers()
                print(data)
                print(data.count)
            } catch {
                print(error)
            }
           
        }
        
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
