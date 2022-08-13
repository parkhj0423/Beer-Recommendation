//
//  BeerViewModel.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/07.
//

import Foundation
import Combine

// MainActor를 붙여주면 구독된 값이 백그라운드 쓰레드에서 바뀌는것을 허용하지 않는다는 오류가 사라짐
@MainActor
final class BeerViewModel : ObservableObject {
    
    private let useCase: BeerUseCaseInterface
    private var bag: Set<AnyCancellable> = Set<AnyCancellable>()
    
    @Published public var beers : [BeerEntity] = []

    init(useCase : BeerUseCaseInterface) {
        self.useCase = useCase
    }
    
    public func getAllBeers() async throws {
        do {
            let beers = try await useCase.getAllBeers()
    //        print(beers)
            self.beers = beers
        } catch NetworkError.decodingError {
            print("#####")
            print("#####")
        } catch NetworkError.badRequestError {
            print(NetworkError.badRequestError.errorMessage)
        }
    }
}
