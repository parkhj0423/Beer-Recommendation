//
//  MockBeerUseCase.swift
//  Beer-RecommendationTests
//
//  Created by 박현우 on 2022/10/22.
//

import Foundation
@testable import Beer_Recommendation

final class MockBeerUseCase : BeerUseCaseInterface {
    typealias BeerEntity = Beer_Recommendation.BeerEntity
    typealias Category = Beer_Recommendation.Category
    
    func getBeersWithPaging(page: Int, size: Int) async throws -> [BeerEntity] {
        return BeerObjectMother.getPagingBeerList(page: 20)
    }
    
    func getRandomBeer() async throws -> BeerEntity? {
        return BeerObjectMother.getSingleBeer()
    }
    
    func getBeerWithKeyword(keyword: String) async throws -> [BeerEntity] {
        return BeerObjectMother.getPagingBeerList(page: 20)
    }
    
    func getBeersByCategory(category: Category) async throws -> [BeerEntity] {
        return BeerObjectMother.getPagingBeerList(page: 20)
    }
    
    
}
