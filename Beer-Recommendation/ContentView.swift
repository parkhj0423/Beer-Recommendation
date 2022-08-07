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
        
        // MVVM, SwiftUI, Combine, Clean Architecture를 사용하여 아키텍쳐에 대해 파볼 예정
        VStack {
            Text("Beer!")
                .padding()
        }
        .task  {
            do {
                let data = try await viewModel.getRandomBeers()
                print(data)
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
