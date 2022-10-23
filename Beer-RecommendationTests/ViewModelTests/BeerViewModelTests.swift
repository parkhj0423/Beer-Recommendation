//
//  BeerViewModelTests.swift
//  Beer-RecommendationTests
//
//  Created by 박현우 on 2022/10/22.
//

import XCTest
@testable import Beer_Recommendation

@MainActor
final class BeerViewModelTests: XCTestCase {
    
    var viewModel : BeerViewModel!
    var mockBeerUseCase : MockBeerUseCase!
    var mockFavoriteUseCase : MockFavoriteUseCase!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockBeerUseCase = MockBeerUseCase()
        mockFavoriteUseCase = MockFavoriteUseCase()
        viewModel = BeerViewModel(beerUseCase: mockBeerUseCase, favoriteUseCase: mockFavoriteUseCase)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        viewModel = nil
        mockBeerUseCase = nil
        mockFavoriteUseCase = nil
    }
    
    
    func testShouldSuccessToGetBeerList() async throws {
        try await viewModel.getBeersWithPaging()
        XCTAssertEqual(viewModel.beers.count, 10)
    }
    
    func testShouldFailToGetBeerListWhenFailToLoadData() async throws {
        mockBeerUseCase.isGetBeerListSuccess = false
        
        try await viewModel.getBeersWithPaging()
        
        XCTAssertEqual(viewModel.viewModelError, .failToLoadData)
    }
    
    func testShouldSuccessToGetRandomBeer() async throws {
        try await viewModel.getRandomBeer()
        XCTAssertNotNil(viewModel.randomBeer)
    }
    
    func testShouldFailToGetRandomBeerWhenFailToLoadData() async throws {
        mockBeerUseCase.isGetRandomBeerSuccess = false
        try await viewModel.getRandomBeer()
        XCTAssertEqual(viewModel.viewModelError, .failToLoadData)
    }
}
