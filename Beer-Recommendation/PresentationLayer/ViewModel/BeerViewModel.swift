//
//  BeerViewModel.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/07.
//

import Foundation
import Combine
import UIKit

public enum Category : String, CaseIterable {
    case all = "All"
    case brewedBefore2000 = "Before 2000's"
    case brewedAfter2000 = "After 2000's"
    case abvOver15 = "ABV over 15"
    case abvUnder15 = "ABV under 15"
}

// MainActor로 선언하여 모든 행위를 메인 쓰레드에서 동작하게 함
@MainActor
final class BeerViewModel : ObservableObject {
    
    private let useCase: BeerUseCaseInterface
    private var bag: Set<AnyCancellable> = Set<AnyCancellable>()
    
    @Published public var beers : [BeerEntity] = []
    @Published public var searchedBeers : [BeerEntity] = []
    @Published public var randomBeer : [BeerEntity] = []
    @Published public var searchKeyword : String = ""
    @Published public var selectedCategory : Category = .all
    
    @Published public var isLoading : Bool = false
    @Published public var viewModelError : BeerViewModelError?
    
    private var currentPage : Int = 1
    private var currentSize : Int = 10
    private var isEmptyListCalled : Bool = false
    
    init(useCase : BeerUseCaseInterface) {
        self.useCase = useCase
        inputKeyword()
    }
    
    public func cleanError() {
        self.viewModelError = nil
    }
    
    public func getBeersWithPaging(page : Int? = nil) async throws {
        cleanError()
        do {
            var beers : [BeerEntity] = []
            
            if let page = page {
                beers = try await useCase.getBeersWithPaging(page: page, size: currentSize)
                self.currentPage = 1
                self.beers = beers
                self.isEmptyListCalled = false
            } else {
                if !isEmptyListCalled {
                    beers = try await useCase.getBeersWithPaging(page: currentPage, size: currentSize)
                } 
                if beers.isEmpty {
                    self.isEmptyListCalled = true
                } else {
                    self.isEmptyListCalled = false
                    self.currentPage += 1
                    self.beers.append(contentsOf: beers)
                }
            }
        } catch NetworkError.internetConnectionError {
            self.viewModelError = .internetConnectionError
        } catch {
            self.viewModelError = .failToLoadData
        }
    }
    
    
    public func getRandomBeer() async throws {
        cleanError()
        do {
            self.isLoading = true
            let randomBeer = try await useCase.getRandomBeer()
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
                Task {
                    UIApplication.shared.endEditing()
                    if keyword != "" {
                        try await self?.getBeerWithKeyword(keyword: keyword)
                    } else {
                        self?.searchedBeers = []
                    }
                }
            })
            .store(in: &bag)
    }
    
    private func getBeerWithKeyword(keyword : String) async throws {
        cleanError()
        do {
            self.isLoading = true
            let searchedBeers = try await useCase.getBeerWithKeyword(keyword: keyword)
            self.searchedBeers = searchedBeers
            self.isLoading = false
            
        } catch {
            self.viewModelError = .failToLoadData
            self.isLoading = false
        }
    }
    
    public func getBeersByCategory() async throws {
        cleanError()
        do {
            self.isLoading = true
            let beersByCategory = try await useCase.getBeersByCategory(category: self.selectedCategory)
            self.beers = beersByCategory
            self.isLoading = false
            
        } catch NetworkError.internetConnectionError {
            self.isLoading = false
            self.viewModelError = .internetConnectionError
        } catch {
            self.viewModelError = .failToLoadData
            self.isLoading = false
        }
    }
    
    public func setCategory(category : Category) {
        self.selectedCategory = category
    }
    
    
    public func getStarCount(beer : BeerEntity) -> Int {
        if let ibu = beer.ibu {
            if ibu >= 80 {
                return 7
            } else if ibu >= 70 {
                return 6
            } else if ibu >= 60 {
                return 5
            } else if ibu >= 50 {
                return 4
            } else if ibu >= 40 {
                return 3
            } else if ibu >= 30 {
                return 2
            } else {
                return 1
            }
        } else {
            return 1
        }
    }
    
    public func addFavorite(beer : BeerEntity) {
        PreferenceUtil().addFavorite(beer: beer)
    }
    
    public func removeFavorite(beer : BeerEntity) {
        PreferenceUtil().removeFavorite(beer: beer)
    }
    
    public func isFavorite(beer : BeerEntity) -> Bool {
        return PreferenceUtil().isFavorite(beer: beer)
    }
    
    public func isLastItem(index : Int) -> Bool {
        return index == beers.count - 1
    }
    
    public func isSearched() -> Bool {
        return !searchedBeers.isEmpty || !self.searchKeyword.isEmpty
    }
    
}
