//
//  BeerDataSource.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/07.
//

import Foundation

protocol BeerDataSourceInterface {
    func getAllBeers() async throws -> [BeerDTO]
    func getRandomBeer() async throws -> [BeerDTO]
    func getBeerWithKeyword(keyword : String) async throws -> [BeerDTO]
}

public final class BeerDataSource : NetworkUtil, BeerDataSourceInterface {
    func getAllBeers() async throws -> [BeerDTO] {
        let url : String = "beers/"
        
        let parameters : [URLQueryItem] = [
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "per_page", value: "5")
        ]
        
        return try await sendRequest(url: url, method: .GET, parameters : parameters)
    }
    
    func getRandomBeer() async throws -> [BeerDTO] {
        let url : String = "beers/random"
        
        return try await sendRequest(url: url, method: .GET)
    }
    
    func getBeerWithKeyword(keyword: String) async throws -> [BeerDTO] {
        let url : String = "beers/"
        
        let parameters : [URLQueryItem] = [
            URLQueryItem(name: "beer_name", value: keyword)
        ]
        
        return try await sendRequest(url: url, method: .GET, parameters : parameters)
    }

}
