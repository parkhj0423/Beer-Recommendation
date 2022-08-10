//
//  BeerViewModel.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/07.
//

import Foundation
import Combine

final class BeerViewModel : ObservableObject {
    
    private let useCase: BeerUseCaseInterface
    private var bag: Set<AnyCancellable> = Set<AnyCancellable>()
    
    @Published public var beers : [BeerEntity] = []

    init(useCase : BeerUseCaseInterface) {
        self.useCase = useCase
    }
    
    public func getAllBeers() async throws {
        let beers = try await useCase.getAllBeers()
//        print(beers)
        self.beers = beers
        
    }
}
