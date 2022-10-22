//
//  MockBeerUseCase.swift
//  Beer-RecommendationTests
//
//  Created by 박현우 on 2022/10/22.
//

import Foundation
@testable import Beer_Recommendation

final class MockBeerUseCase : BeerUseCaseInterface {
    func getBeersWithPaging(page: Int, size: Int) async throws -> [BeerEntity] {
        
    }
    
    func getRandomBeer() async throws -> [BeerEntity] {
        
    }
    
    func getBeerWithKeyword(keyword: String) async throws -> [BeerEntity] {
        
    }
    
    func getBeersByCategory(category: Category) async throws -> [BeerEntity] {
        
    }
    
    
}
