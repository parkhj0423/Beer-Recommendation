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
    let volume, boil_volume: BoilVolumeDTO
    let method: MethodDTO?
    let ingredients: IngredientsDTO
    let food_pairing: [String]
    let brewers_tips: String?
    let contributed_by: String?
}

// MARK: - BoilVolume
struct BoilVolumeDTO : Codable  {
    let value: Double
    let unit: String
}

// MARK: - Ingredients
struct IngredientsDTO : Codable  {
    let malt: [MaltDTO]
    let hops: [HopDTO]
    let yeast: String?
}

// MARK: - Hop
struct HopDTO : Codable  {
    let name: String?
    let amount: BoilVolumeDTO
    let add: String?
    let attribute: String?
}

// MARK: - Malt
struct MaltDTO : Codable  {
    let name: String
    let amount: BoilVolumeDTO
}

// MARK: - Method
struct MethodDTO : Codable  {
    let mash_temp: [MashTempDTO]
    let fermentation: FermentationDTO
    let twist: String?
}

// MARK: - Fermentation
struct FermentationDTO : Codable  {
    let temp: BoilVolumeDTO
}

// MARK: - MashTemp
struct MashTempDTO : Codable {
    let temp: BoilVolumeDTO
    let duration: Int?
}
