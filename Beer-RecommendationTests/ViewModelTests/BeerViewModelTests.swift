//
//  BeerViewModelTests.swift
//  Beer-RecommendationTests
//
//  Created by 박현우 on 2022/10/22.
//

import XCTest
@testable import Beer_Recommendation

final class BeerViewModelTests: XCTestCase {
    
    var viewModel : BeerViewModel!
    var mockBeerUseCase : MockBeerUseCase!
    var mockFavoriteUseCase : MockFavoriteUseCase!

    @MainActor override func setUpWithError() throws {
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

    
    @MainActor func testShouldGetBeerListWithPaging() async throws {
        try await viewModel.getBeersWithPaging(page: 20)
        XCTAssertEqual(viewModel.beers.count, 20)
    }

}
