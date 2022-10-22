//
//  MockFavoriteUseCase.swift
//  Beer-RecommendationTests
//
//  Created by 박현우 on 2022/10/22.
//

import Foundation
@testable import Beer_Recommendation

final class MockFavoriteUseCase : FavoriteUseCaseInterface {
    func getFavoriteList() -> [BeerEntity] {
        
    }
    
    func addFavorite(beer: BeerEntity) -> [BeerEntity] {
        
    }
    
    func removeFavorite(beer: BeerEntity) -> [BeerEntity] {
        
    }
    
    func isFavorite(beer: BeerEntity) -> Bool {
        
    }
    
    
}
