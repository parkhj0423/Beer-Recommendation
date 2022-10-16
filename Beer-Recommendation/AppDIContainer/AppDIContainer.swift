//
//  AppDIContainer.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/13.
//

import Foundation
import SwiftUI

struct AppDIContainer {
    @MainActor static func getBeerDependencies() -> BeerViewModel {
        let beerDataSource : BeerDataSourceInterface = BeerDataSource()
        let beerRepository : BeerRepositoryInterface = BeerRepository(dataSource: beerDataSource)
        let beerUseCase : BeerUseCaseInterface = BeerUseCase(repository: beerRepository)
        
        let userDefaultRepository : UserDefaultsRepositoryInterface = UserDefaultsRepository()
        let favoriteUseCase : FavoriteUseCaseInterface = FavoriteUseCase(repository: userDefaultRepository)
        
        let beerViewModel : BeerViewModel = BeerViewModel(beerUseCase: beerUseCase, favoriteUseCase: favoriteUseCase)
        
        return beerViewModel
    }
    
    @MainActor static func getFavoriteDependencies() -> FavoriteViewModel {
        let userDefaultRepository : UserDefaultsRepositoryInterface = UserDefaultsRepository()
        let favoriteUseCase : FavoriteUseCaseInterface = FavoriteUseCase(repository: userDefaultRepository)
        let favoriteViewModel : FavoriteViewModel = FavoriteViewModel(useCase: favoriteUseCase)

        return favoriteViewModel
    }
}
