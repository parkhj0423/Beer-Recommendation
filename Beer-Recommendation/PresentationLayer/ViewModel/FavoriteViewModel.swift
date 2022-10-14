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
    
    init(useCase : FavoriteUseCaseInterface) {
        self.useCase = useCase
    }
    
}
