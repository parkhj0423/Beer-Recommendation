//
//  UserDefaultsRepository.swift
//  Beer-Recommendation
//
//  Created by 박현우 on 2022/10/14.
//

import Foundation

final class UserDefaultsRepository : UserDefaultsRepositoryInterface {
    
    private let dataSource : BeerDataSourceInterface
    
    public init(dataSource : BeerDataSourceInterface) {
        self.dataSource = dataSource
    }
    
    
}
