//
//  FavoriteViewModel.swift
//  Beer-Recommendation
//
//  Created by 박현우 on 2022/10/14.
//

import Foundation
import Combine

@MainActor
final class FavoriteViewModel : ObservableObject {
    
    private let useCase: FavoriteUseCaseInterface
    private var bag: Set<AnyCancellable> = Set<AnyCancellable>()
    
    @Published public var favoriteList : [BeerEntity] = []
    
    init(useCase : FavoriteUseCaseInterface) {
        self.useCase = useCase
    }
    
    public func getFavoriteList() {
        self.favoriteList = useCase.getFavoriteList()
    }
    
    public func addFavorite(beer : BeerEntity) {
        self.favoriteList = useCase.addFavorite(beer: beer)
    }
    
    public func removeFavorite(beer : BeerEntity) {
        self.favoriteList = useCase.removeFavorite(beer: beer)
    }
    
    public func isFavorite(beer : BeerEntity) -> Bool {
        return useCase.isFavorite(beer: beer)
    }
    
    
    
}
