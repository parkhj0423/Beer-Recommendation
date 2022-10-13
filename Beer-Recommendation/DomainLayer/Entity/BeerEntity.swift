//
//  BeerEntity.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/07.
//

import Foundation

// MARK: - BeerEntity
struct BeerEntity : Codable, Identifiable, Equatable {
    let id: Int
    let name, tagline, firstBrewed, description: String?
    let imageUrl: String?
    // %로 나타내는 알콜 도수
    let abv: Double?
    // 쓴맛의 정도 숫자가 높을 수록 크다 (보통의 IPA가 70 정도)
    let ibu: Double?
    // 효모를 넣고 발효 후 물에 비해 얼마나 무거운 가를 나타내는 수치
    let targetFg: Double?
    // 발효 전 물에 비해 얼마나 무거운 가를 나타내는 수치
    let targetOg: Double?
    // 유럽 기준) 색의 짙은 정도 숫자가 높을 수록 짙다 (보통의 IPA가 12~13, 스타우트가 35)
    let ebc: Double?
    // 미국 기준) 색의 짙은 정도 숫자가 높을 수록 짙다 (보통의 IPA가 12~13, 스타우트가 35)
    let srm : Double?
    let ph : Double?
    // 발효도
    let attenuationLevel: Double?
    let volume, boilVolume: BoilVolumeEntity?
    let method: MethodEntity?
    let ingredients: IngredientsEntity?
    let foodPairing: [String]
    let brewersTips: String?
    let contributedBy: String?
}

// MARK: - BoilVolume
struct BoilVolumeEntity : Codable  {
    let value: Double?
    let unit: String?
}

// MARK: - Ingredients
struct IngredientsEntity : Codable  {
    let malt: [MaltEntity]?
    let hops: [HopEntity]?
    // 효모
    let yeast: String?
}

// MARK: - Hop
struct HopEntity : Codable, Identifiable  {
    public var id  = UUID()
    let name: String?
    let amount: BoilVolumeEntity?
    let add: String?
    let attribute: String?
}

// MARK: - Malt
struct MaltEntity : Codable, Identifiable  {
    public var id  = UUID()
    let name: String?
    let amount: BoilVolumeEntity?
}

// MARK: - Method
struct MethodEntity : Codable  {
    let mashTemp: [MashTempEntity]?
    let fermentation: FermentationEntity?
    let twist: String?
}

// MARK: - Fermentation
struct FermentationEntity : Codable  {
    let temp: BoilVolumeEntity?
}

// MARK: - MashTemp
struct MashTempEntity : Codable {
    let temp: BoilVolumeEntity?
    let duration: Int?
}
