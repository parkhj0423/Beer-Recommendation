//
//  FavoriteUseCase.swift
//  Beer-Recommendation
//
//  Created by 박현우 on 2022/10/15.
//

import Foundation

protocol FavoriteUseCaseInterface {
    func getFavoriteList() -> [BeerEntity]
    func addFavorite(beer : BeerEntity) -> [BeerEntity]
    func removeFavorite(beer : BeerEntity) -> [BeerEntity]
    func isFavorite(beer : BeerEntity) -> Bool
}

final class FavoriteUseCase : FavoriteUseCaseInterface {
    
    private let repository : UserDefaultsRepositoryInterface
    
    public init(repository : UserDefaultsRepositoryInterface) {
        self.repository = repository
    }
   
    func getFavoriteList() -> [BeerEntity] {
        return repository.getFavoriteList()
    }
    
    func addFavorite(beer: BeerEntity) -> [BeerEntity] {
        return repository.addFavorite(beer: beer)
    }
    
    func removeFavorite(beer: BeerEntity) -> [BeerEntity] {
        return repository.removeFavorite(beer: beer)
    }
    
    func isFavorite(beer: BeerEntity) -> Bool {
        return repository.isFavorite(beer: beer)
    }
    
    
    
}
