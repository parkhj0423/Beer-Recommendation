//
//  BeerRepositoryInterface.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/07.
//

import Foundation

protocol BeerRepositoryInterface {
    func getAllBeers() async throws -> [BeerEntity]
}
