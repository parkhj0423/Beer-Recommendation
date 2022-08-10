//
//  BeerUseCase.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/07.
//

import Foundation

protocol BeerUseCaseInterface {
    func getAllBeers() async throws -> [BeerEntity]
}

final class BeerUseCase : BeerUseCaseInterface {
    
    private let repository : BeerRepositoryInterface
    
    public init(repository : BeerRepositoryInterface) {
        self.repository = repository
    }
    
    func getAllBeers() async throws -> [BeerEntity] {
        return try await repository.getAllBeers()
    }
    
    
}
