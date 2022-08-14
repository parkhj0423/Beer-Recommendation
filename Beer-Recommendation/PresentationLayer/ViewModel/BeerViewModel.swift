//
//  BeerViewModel.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/07.
//

import Foundation
import Combine

// MainActor로 선언하여 모든 행위를 메인 쓰레드에서 동작하게 함
@MainActor
final class BeerViewModel : ObservableObject {
    
    private let useCase: BeerUseCaseInterface
    private var bag: Set<AnyCancellable> = Set<AnyCancellable>()
    
    @Published public var beers : [BeerEntity] = []
    
    @Published public var isLoading : Bool = false
    
    init(useCase : BeerUseCaseInterface) {
        self.useCase = useCase
    }
    
    public func getAllBeers() async throws {
        do {
            self.isLoading = true
            
            let beers = try await useCase.getAllBeers()
            self.beers = beers
            
            self.isLoading = false
        } catch NetworkError.internetConnectionError {
            print(NetworkError.internetConnectionError.errorMessage)
            self.isLoading = false
        } catch  {
            print("Fail to load data")
            self.isLoading = false
        }
    }
}
