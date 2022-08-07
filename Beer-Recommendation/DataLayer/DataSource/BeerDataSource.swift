//
//  BeerDataSource.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/07.
//

import Foundation

protocol BeerDataSourceInterface {
    func getRandomBeers() async throws -> [BeerDTO]
}

public final class BeerDataSource : NetworkUtil, BeerDataSourceInterface {
    func getRandomBeers() async throws -> [BeerDTO] {
        let url : String = "beers/random"
        
        return try await sendRequest(url: url, method: .GET)
    }

}
