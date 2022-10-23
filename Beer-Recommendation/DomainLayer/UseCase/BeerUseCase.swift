//
//  BeerUseCase.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/07.
//

import Foundation

protocol BeerUseCaseInterface {
    func getBeersWithPaging(page : Int, size : Int) async throws -> [BeerEntity]
    func getRandomBeer() async throws -> BeerEntity?
    func getBeerWithKeyword(keyword : String) async throws -> [BeerEntity]
    func getBeersByCategory(category : Category) async throws -> [BeerEntity]
}

final class BeerUseCase : BeerUseCaseInterface {
    
    private let repository : BeerRepositoryInterface
    
    public init(repository : BeerRepositoryInterface) {
        self.repository = repository
    }
    
    func getBeersWithPaging(page : Int, size : Int) async throws -> [BeerEntity] {
        return try await repository.getBeersWithPaging(page: page, size: size)
    }
    
    func getRandomBeer() async throws -> BeerEntity? {
        return try await repository.getRandomBeer().first
    }
    
    func getBeerWithKeyword(keyword : String) async throws -> [BeerEntity] {
        return try await repository.getBeerWithKeyword(keyword: keyword)
    }
    
    func getBeersByCategory(category : Category) async throws -> [BeerEntity] {
        return try await repository.getBeersByCategory(category: category)
    }
}
