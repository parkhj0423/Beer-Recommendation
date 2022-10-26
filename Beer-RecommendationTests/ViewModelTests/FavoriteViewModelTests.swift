//
//  FavoriteViewModelTests.swift
//  Beer-RecommendationTests
//
//  Created by 박현우 on 2022/10/26.
//

import XCTest
@testable import Beer_Recommendation

@MainActor
final class FavoriteViewModelTests: XCTestCase {

    var viewModel : FavoriteViewModel!
    var mockFavoriteUseCase : MockFavoriteUseCase!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockFavoriteUseCase = MockFavoriteUseCase()
        viewModel = FavoriteViewModel(useCase: mockFavoriteUseCase)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        viewModel = nil
        mockFavoriteUseCase = nil
    }

    func testShouldSuccessToGetFavoriteList() {
        viewModel.getFavoriteList()
        
        XCTAssertEqual(viewModel.favoriteList.count, 5)
    }
    
    func testShouldSuccessToAddFavorite() {
        viewModel.getFavoriteList()
        
        viewModel.addFavorite(beer: BeerObjectMother.emptyBeerEntity)
        
        XCTAssertEqual(viewModel.favoriteList.count, 6)
    }
    
    func testShouldSuccessToRemoveFavorite() {
        viewModel.getFavoriteList()
        
        viewModel.removeFavorite(beer: BeerObjectMother.emptyBeerEntity)
        
        XCTAssertEqual(viewModel.favoriteList.count, 4)
    }
    
}
