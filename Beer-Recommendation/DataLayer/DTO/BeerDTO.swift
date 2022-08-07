//
//  BeerDTO.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/07.
//

import Foundation

// MARK: - BeerDTO
struct BeerDTO : Codable {
    let id: Int
    let name, tagline, first_brewed, description: String?
    let image_url: String?
    let abv: Double?
    let ibu: Double?
    let target_fg: Int?
    let target_og: Double?
    let ebc: Int?
    let srm, ph: Double?
    let attenuation_level: Double?
    let volume, boil_volume: BoilVolume
    let method: Method?
    let ingredients: Ingredients
    let food_pairing: [String]
    let brewers_tips: String?
    let contributed_by: String?
}

// MARK: - BoilVolume
struct BoilVolume : Codable  {
    let value: Double
    let unit: String
}

// MARK: - Ingredients
struct Ingredients : Codable  {
    let malt: [Malt]
    let hops: [Hop]
    let yeast: String?
}

// MARK: - Hop
struct Hop : Codable  {
    let name: String?
    let amount: BoilVolume
    let add: String?
    let attribute: String?
}

// MARK: - Malt
struct Malt : Codable  {
    let name: String
    let amount: BoilVolume
}

// MARK: - Method
struct Method : Codable  {
    let mash_temp: [MashTemp]
    let fermentation: Fermentation
    let twist: String?
}

// MARK: - Fermentation
struct Fermentation : Codable  {
    let temp: BoilVolume
}

// MARK: - MashTemp
struct MashTemp : Codable {
    let temp: BoilVolume
    let duration: Int?
}
