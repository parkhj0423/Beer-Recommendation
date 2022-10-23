//
//  MockFavoriteUseCase.swift
//  Beer-RecommendationTests
//
//  Created by 박현우 on 2022/10/22.
//

import Foundation
@testable import Beer_Recommendation

final class MockFavoriteUseCase : FavoriteUseCaseInterface {
    typealias BeerEntity = Beer_Recommendation.BeerEntity
    typealias Category = Beer_Recommendation.Category
    
    func getFavoriteList() -> [BeerEntity] {
        return BeerObjectMother.getPagingBeerList(page: 20)
    }
    
    func addFavorite(beer: BeerEntity) -> [BeerEntity] {
        return BeerObjectMother.getPagingBeerList(page: 20)
    }
    
    func removeFavorite(beer: BeerEntity) -> [BeerEntity] {
        return BeerObjectMother.getPagingBeerList(page: 20)
    }
    
    func isFavorite(beer: BeerEntity) -> Bool {
        return true
    }
    
    
}
