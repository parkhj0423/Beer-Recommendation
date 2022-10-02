//
//  PreferenceUtil.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/23.
//

import Foundation

let FAVORITE = "favorite"

class PreferenceUtil : NSObject {
    @UserDefaultWrapper(key: FAVORITE, defaultValue: nil) static var favoriteList : [BeerEntity]?
    
    func getFavoriteList() -> [BeerEntity] {
        return PreferenceUtil.favoriteList ?? []
    }
    
    func addFavorite(beer : BeerEntity) {
        PreferenceUtil.favoriteList?.append(beer)
    }
    
    func removeFavorite(beer : BeerEntity) {
        let filteredList =  PreferenceUtil.favoriteList?.filter({ favoriteItem in
            return beer.id != favoriteItem.id
        })
        
        PreferenceUtil.favoriteList = filteredList
    }
    
    func isFavorite(beer : BeerEntity) -> Bool {
        guard let isContain = PreferenceUtil.favoriteList?.contains(where: { favoriteItem in
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
