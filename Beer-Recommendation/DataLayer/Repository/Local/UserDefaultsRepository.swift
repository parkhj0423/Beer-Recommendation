//
//  UserDefaultsRepository.swift
//  Beer-Recommendation
//
//  Created by 박현우 on 2022/10/14.
//

import Foundation

final class UserDefaultsRepository : UserDefaultsRepositoryInterface {
    
    private let userDefaultsStorage : UserDefaultsStorage = UserDefaultsStorage()
    
    func getFavoriteList() -> [BeerEntity] {
        return userDefaultsStorage.getFavoriteList()
    }
    
    func addFavorite(beer : BeerEntity) -> [BeerEntity] {
        userDefaultsStorage.addFavorite(beer: beer)
        
        return userDefaultsStorage.getFavoriteList()
    }
    
    func removeFavorite(beer : BeerEntity) -> [BeerEntity] {
        userDefaultsStorage.removeFavorite(beer: beer)
        
        return userDefaultsStorage.getFavoriteList()
    }
    
    func isFavorite(beer : BeerEntity) -> Bool {
        return userDefaultsStorage.isFavorite(beer: beer)
    }
        
}
