//
//  PreferenceManager.swift
//  Beer-Recommendation
//
//  Created by 박현우 on 2022/10/02.
//

import Foundation

struct PreferenceManager {
    @UserDefaultWrapper(key: "favorite", defaultValue: nil)
    static var favoriteList : [BeerEntity]?
}
