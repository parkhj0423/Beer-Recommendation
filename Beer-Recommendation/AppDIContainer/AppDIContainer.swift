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
        let beerViewModel : BeerViewModel = BeerViewModel(useCase: beerUseCase)
        
        return beerViewModel
    }
    
    @MainActor static func getFavoriteDependencies() -> FavoriteViewModel {
        let beerDataSource : BeerDataSourceInterface = BeerDataSource()
        let beerRepository : UserDefaultsRepositoryInterface = UserDefaultsRepository(dataSource: beerDataSource)
        let beerUseCase : BeerUseCaseInterface = BeerUseCase(repository: beerRepository)
        let beerViewModel : FavoriteViewModel = FavoriteViewModel(useCase: beerUseCase)

        return beerViewModel
    }
}
