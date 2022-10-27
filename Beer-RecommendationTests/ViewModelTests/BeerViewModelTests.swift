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
        // given
        // when
        try await viewModel.getBeersWithPaging()
        
        // then
        XCTAssertEqual(viewModel.beers.count, 10)
        XCTAssertNil(viewModel.viewModelError)
    }
    
    func testShouldFailToGetBeerListWhenFailToLoadData() async throws {
        // given
        mockBeerUseCase.isGetBeerListSuccess = false
        
        // when
        try await viewModel.getBeersWithPaging()
        
        //then
        XCTAssertEqual(viewModel.viewModelError, .failToLoadData)
    }
    
    func testShouldSuccessToGetRandomBeer() async throws {
        // given
        // when
        try await viewModel.getRandomBeer()
        
        // then
        XCTAssertNotNil(viewModel.randomBeer)
        XCTAssertNil(viewModel.viewModelError)
    }
    
    func testShouldFailToGetRandomBeerWhenFailToLoadData() async throws {
        // given
        mockBeerUseCase.isGetRandomBeerSuccess = false
        
        // when
        try await viewModel.getRandomBeer()
        
        // then
        XCTAssertEqual(viewModel.viewModelError, .failToLoadData)
    }
}
