//
//  BeerDTO.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/07.
//

import Foundation

// MARK: - BeerDTO
struct BeerDTO : Codable {
    let idz: Int
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
    
    public func toEntity() -> BeerEntity {
        
        // MARK: volume
        let volumeEntity : BoilVolumeEntity = BoilVolumeEntity(value: volume.value, unit: volume.unit)
        
        // MARK: boilVolume
        let boilVolumeEntity : BoilVolumeEntity = BoilVolumeEntity(value: boil_volume.value, unit: boil_volume.unit)
        
        // MARK: method
        var meshTempEntities : [MashTempEntity] = []
        method?.mash_temp.forEach{ mashTempDTO in
            meshTempEntities.append(
                MashTempEntity(
                    temp: BoilVolumeEntity(value: mashTempDTO.temp.value, unit: mashTempDTO.temp.unit),
                    duration: mashTempDTO.duration)
            )
        }
        
        let fermantationEntity : FermentationEntity = FermentationEntity(
            temp: BoilVolumeEntity(value: method?.fermentation.temp.value ?? 0, unit: method?.fermentation.temp.unit ?? "")
        )
        
        let methodEntity : MethodEntity = MethodEntity(mashTemp: meshTempEntities, fermentation: fermantationEntity, twist: method?.twist)
        
        
        // MARK: ingredients
        var maltEntities : [MaltEntity] = []
        ingredients.malt.forEach { maltDTO in
            maltEntities.append(MaltEntity(name: maltDTO.name, amount: BoilVolumeEntity(value: maltDTO.amount.value, unit: maltDTO.amount.unit)))
        }
        
        var hopEntities : [HopEntity] = []
        ingredients.hops.forEach { hopDTO in
            hopEntities.append(HopEntity(name: hopDTO.name, amount: BoilVolumeEntity(value: hopDTO.amount.value, unit: hopDTO.amount.unit), add: hopDTO.add, attribute: hopDTO.attribute))
        }
        
        let ingredientsEntity : IngredientsEntity = IngredientsEntity(malt: maltEntities, hops: hopEntities, yeast: ingredients.yeast)
            
        
        return BeerEntity(
                id: idz,
                name: name,
                tagline: tagline,
                firstBrewed: first_brewed,
                description: description,
                imageUrl: image_url,
                abv: abv,
                ibu: ibu,
                targetFg: target_fg,
                targetOg: target_og,
                ebc: ebc,
                srm: srm,
                ph: ph,
                attenuationLevel: attenuation_level,
                volume: volumeEntity,
                boilVolume: boilVolumeEntity,
                method: methodEntity,
                ingredients: ingredientsEntity,
                foodPairing: food_pairing,
                brewersTips: brewers_tips,
                contributedBy: contributed_by)
        
    }
    
    
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
