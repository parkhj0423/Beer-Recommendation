//
//  PreferenceUtil.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/23.
//

import Foundation

let FAVORITE = "favorite"

class PreferenceUtil : NSObject {
    let userDefaults = UserDefaults.standard
    
    
    func getFavoriteList() -> [BeerEntity] {
        return PreferenceManager.favoriteList ?? []
    }
    
    func addFavorite(beer : BeerEntity) {
        var currentFavoriteList = PreferenceManager.favoriteList
        
        currentFavoriteList?.append(beer)
        
        PreferenceManager.favoriteList = currentFavoriteList
    }
    
    func removeFavorite(beer : BeerEntity) {
        var currentFavoriteList : [BeerEntity] = getFavoriteList()
        
        currentFavoriteList = currentFavoriteList.filter({ favoriteItem in
            return beer.id != favoriteItem.id
        })
        
        userDefaults.set(currentFavoriteList, forKey: FAVORITE)
        userDefaults.synchronize()
    }
    
    func isFavorite(beer : BeerEntity) -> Bool {
        let currentFavoriteList : [BeerEntity] = getFavoriteList()
        
        let isContain = currentFavoriteList.contains(where: { favoriteItem in
            return beer.id == favoriteItem.id
        })
        
        if isContain {
            return true
        }
        
        return false
    }
}
