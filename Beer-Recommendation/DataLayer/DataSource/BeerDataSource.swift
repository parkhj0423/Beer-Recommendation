//
//  BeerDataSource.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/07.
//

import Foundation

protocol BeerDataSourceInterface {
    func getBeersWithPaging(page : Int, size : Int) async throws -> [BeerDTO]
    func getRandomBeer() async throws -> [BeerDTO]
    func getBeerWithKeyword(keyword : String) async throws -> [BeerDTO]
    func getBeersByCategory(category : Category) async throws -> [BeerDTO]
}

public final class BeerDataSource : NetworkUtil, BeerDataSourceInterface {
    func getBeersWithPaging(page : Int, size : Int) async throws -> [BeerDTO] {
        let url : String = "beers/"
        
        let parameters : [URLQueryItem] = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "per_page", value: "\(size)")
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
    
    func getBeersByCategory(category : Category) async throws -> [BeerDTO] {
        let url : String = "beers/"
        
        var parameters : [URLQueryItem] = []
        
        switch category {
        case .all:
            break
        case .brewedBefore2000:
            parameters.append(URLQueryItem(name: "brewed_before", value: "01-2000"))
        case .brewedAfter2000:
            parameters.append(URLQueryItem(name: "brewed_after", value: "01-2000"))
        case .abvOver15:
            parameters.append(URLQueryItem(name: "abv_gt", value: "15"))
        case .abvUnder15:
            parameters.append(URLQueryItem(name: "abv_lt", value: "15"))
        }
        
        return try await sendRequest(url: url, method: .GET, parameters : parameters)
    }

}
