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
    
    var isFavorite : Bool = true
    
    func getFavoriteList() -> [BeerEntity] {
        return BeerObjectMother.getFavoriteBeerList()
    }
    
    func addFavorite(beer: BeerEntity) -> [BeerEntity] {
        var beerList : [BeerEntity] = BeerObjectMother.getFavoriteBeerList()
        beerList.append(beer)
        return beerList
    }
    
    func removeFavorite(beer: BeerEntity) -> [BeerEntity] {
        let beerList : [BeerEntity] = BeerObjectMother.getFavoriteBeerList().dropLast()
                
        return beerList
    }
    
    func isFavorite(beer: BeerEntity) -> Bool {
        if !isFavorite {
            return false
        }
        return true
    }
    
    
}
