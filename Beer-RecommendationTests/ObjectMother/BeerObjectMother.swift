//
//  BeerObjectMother.swift
//  Beer-RecommendationTests
//
//  Created by 박현우 on 2022/10/22.
//

import Foundation
@testable import Beer_Recommendation

class BeerObjectMother {
    
    static let emptyBeerEntity : BeerEntity = BeerEntity(id: 1, name: nil, tagline: nil, firstBrewed: nil, description: nil, imageUrl: nil, abv: nil, ibu: nil, targetFg: nil, targetOg: nil, ebc: nil, srm: nil, ph: nil, attenuationLevel: nil, volume: nil, boilVolume: nil, method: nil, ingredients: nil, foodPairing: [], brewersTips: nil, contributedBy: nil)
    
    static func getBeerList() -> [BeerEntity] {
        let beerList : [BeerEntity] = Array(repeating: emptyBeerEntity, count: 10)
        
        return beerList
    }
    
    static func getSingleBeer() -> BeerEntity? {
        return emptyBeerEntity
    }
    
    static func getFavoriteBeerList() -> [BeerEntity] {
        let beerList : [BeerEntity] = Array(repeating: emptyBeerEntity, count: 5)
        
        return beerList
    }
}
