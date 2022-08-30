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
    @Published public var randomBeer : [BeerEntity] = []
    @Published public var searchKeyword : String = ""
    
    @Published public var isLoading : Bool = false
    @Published public var viewModelError : BeerViewModelError?
    
    init(useCase : BeerUseCaseInterface) {
        self.useCase = useCase
        
        inputKeyword()
        
    }
    
    public func cleanError() {
        self.viewModelError = nil
    }
    
    public func getAllBeers() async throws {
        cleanError()
        do {
            self.isLoading = true
            let beers = try await useCase.getAllBeers()
            self.beers = beers
            self.isLoading = false
        } catch NetworkError.internetConnectionError {
            self.isLoading = false
            self.viewModelError = .internetConnectionError
        } catch {
            self.viewModelError = .failToLoadData
            self.isLoading = false
        }
    }
    
    
    public func getRandomBeer() async throws {
        do {
            self.isLoading = true
            let randomBeer = try await useCase.getRandomBeer()
            print(randomBeer)
            self.randomBeer = randomBeer
            self.isLoading = false
        } catch NetworkError.internetConnectionError {
            print(NetworkError.internetConnectionError.errorMessage)
            self.isLoading = false
            self.viewModelError = .internetConnectionError
        } catch  {
            self.viewModelError = .failToLoadData
            self.isLoading = false
        }
    }
    
    private func inputKeyword() {
        $searchKeyword
            .debounce(for: .seconds(1.5), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] keyword in
                if keyword != "" {
                    print(keyword)
                }
            })
            .store(in: &bag)
    }
}
