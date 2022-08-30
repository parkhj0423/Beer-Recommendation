//
//  BeerRepository.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/07.
//

import Foundation

final class BeerRepository : BeerRepositoryInterface {
    
    private let dataSource : BeerDataSourceInterface
    
    public init(dataSource : BeerDataSourceInterface) {
        self.dataSource = dataSource
    }
    
    
    func getAllBeers() async throws -> [BeerEntity] {
        return try await dataSource.getAllBeers()
            .map({ beerDTO in
                let beerEntity = beerDTO.toEntity()
                return beerEntity
            })
    }
    
    func getRandomBeer() async throws -> [BeerEntity] {
        return try await dataSource.getRandomBeer()
            .map({ beerDTO in
                let beerEntity = beerDTO.toEntity()
                return beerEntity
            })
    }
    
    func getBeerWithKeyword(keyword : String) async throws -> [BeerEntity] {
        return try await dataSource.getBeerWithKeyword(keyword: keyword)
            .map({ beerDTO in
                let beerEntity = beerDTO.toEntity()
                return beerEntity
            })
    }

}
