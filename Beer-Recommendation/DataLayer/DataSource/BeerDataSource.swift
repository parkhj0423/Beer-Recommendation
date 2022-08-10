//
//  BeerDataSource.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/07.
//

import Foundation

protocol BeerDataSourceInterface {
    func getAllBeers() async throws -> [BeerDTO]
}

public final class BeerDataSource : NetworkUtil, BeerDataSourceInterface {
    func getAllBeers() async throws -> [BeerDTO] {
        let url : String = "beers/"
        
//        let parameters : [URLQueryItem] = [
//            URLQueryItem(name: "page", value: "1"),
//            URLQueryItem(name: "per_page", value: "5")
//        ]
        
        let result : [BeerDTO] = try await sendRequest(url: url, method: .GET)
        print(result)
        return result
    }

}
