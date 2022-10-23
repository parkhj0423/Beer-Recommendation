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
    
    var isGetBeerListSuccess : Bool = true
    var isGetRandomBeerSuccess : Bool = true
    
    func getBeersWithPaging(page: Int, size: Int) async throws -> [BeerEntity] {
        if !isGetBeerListSuccess {
            throw BeerViewModelError.failToLoadData
        }
        return BeerObjectMother.getBeerList()
    }
    
    func getRandomBeer() async throws -> BeerEntity? {
        if !isGetRandomBeerSuccess {
            throw BeerViewModelError.failToLoadData
        }
        return BeerObjectMother.getSingleBeer()
    }
    
    func getBeerWithKeyword(keyword: String) async throws -> [BeerEntity] {
        return BeerObjectMother.getBeerList()
    }
    
    func getBeersByCategory(category: Category) async throws -> [BeerEntity] {
        return BeerObjectMother.getBeerList()
    }
    
    
}
