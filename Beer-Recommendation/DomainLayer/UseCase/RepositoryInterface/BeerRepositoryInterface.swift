//
//  BeerRepositoryInterface.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/07.
//

import Foundation

protocol BeerRepositoryInterface {
    func getBeersWithPaging(page : Int, size : Int) async throws -> [BeerEntity]
    func getRandomBeer() async throws -> [BeerEntity]
    func getBeerWithKeyword(keyword : String) async throws -> [BeerEntity]
}
