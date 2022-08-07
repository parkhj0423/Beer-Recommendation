//
//  BeerEntity.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/07.
//

import Foundation

// MARK: - BeerEntity
struct BeerEntity : Codable {
    let id: Int
    let name, tagline, firstBrewed, description: String?
    let imageUrl: String?
    let abv: Double?
    let ibu: Double?
    let targetFg: Int?
    let targetOg: Double?
    let ebc: Int?
    let srm, ph: Double?
    let attenuationLevel: Double?
    let volume, boilVolume: BoilVolumeEntity
    let method: MethodEntity?
    let ingredients: IngredientsEntity
    let foodPairing: [String]
    let brewersTips: String?
    let contributedBy: String?
}

// MARK: - BoilVolume
struct BoilVolumeEntity : Codable  {
    let value: Double
    let unit: String
}

// MARK: - Ingredients
struct IngredientsEntity : Codable  {
    let malt: [MaltEntity]
    let hops: [HopEntity]
    let yeast: String?
}

// MARK: - Hop
struct HopEntity : Codable  {
    let name: String?
    let amount: BoilVolumeEntity
    let add: String?
    let attribute: String?
}

// MARK: - Malt
struct MaltEntity : Codable  {
    let name: String
    let amount: BoilVolumeEntity
}

// MARK: - Method
struct MethodEntity : Codable  {
    let mashTemp: [MashTempEntity]
    let fermentation: FermentationEntity
    let twist: String?
}

// MARK: - Fermentation
struct FermentationEntity : Codable  {
    let temp: BoilVolumeEntity
}

// MARK: - MashTemp
struct MashTempEntity : Codable {
    let temp: BoilVolumeEntity
    let duration: Int?
}
