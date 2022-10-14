//
//  UserDefaultsStorage.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/23.
//

import Foundation

let FAVORITE = "favorite"

class UserDefaultsStorage : NSObject {
    @UserDefaultWrapper(key: FAVORITE, defaultValue: nil) static var favoriteList : [BeerEntity]?
    
    func getFavoriteList() -> [BeerEntity] {
        return UserDefaultsStorage.favoriteList ?? []
    }
    
    func addFavorite(beer : BeerEntity) {
        UserDefaultsStorage.favoriteList?.append(beer)
    }
    
    func removeFavorite(beer : BeerEntity) {
        let filteredList =  UserDefaultsStorage.favoriteList?.filter({ favoriteItem in
            return beer.id != favoriteItem.id
        })
        
        UserDefaultsStorage.favoriteList = filteredList
    }
    
    func isFavorite(beer : BeerEntity) -> Bool {
        guard let isContain = UserDefaultsStorage.favoriteList?.contains(where: { favoriteItem in
            return beer.id == favoriteItem.id
        }) else {
            return false
        }

        if isContain {
            return true
        }

        return false
    }
}
