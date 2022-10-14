//
//  FavoriteUseCase.swift
//  Beer-Recommendation
//
//  Created by 박현우 on 2022/10/15.
//

import Foundation

protocol FavoriteUseCaseInterface {
    
}

final class FavoriteUseCase : FavoriteUseCaseInterface {
    
    private let repository : UserDefaultsRepositoryInterface
    
    public init(repository : UserDefaultsRepositoryInterface) {
        self.repository = repository
    }
   
}
