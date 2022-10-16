//
//  UserDefaultsRepositoryInterface.swift
//  Beer-Recommendation
//
//  Created by 박현우 on 2022/10/14.
//

import Foundation

protocol UserDefaultsRepositoryInterface {
    func getFavoriteList() -> [BeerEntity]
    func addFavorite(beer : BeerEntity) -> [BeerEntity]
    func removeFavorite(beer : BeerEntity) -> [BeerEntity]
    func isFavorite(beer : BeerEntity) -> Bool
}
