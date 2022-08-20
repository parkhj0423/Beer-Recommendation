//
//  Beer_RecommendationApp.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/07/27.
//

import SwiftUI

@main
struct Beer_RecommendationApp: App {
    let sheetManager : SheetManager = SheetManager()
    
    var body: some Scene {
        WindowGroup {
            BeerListView(viewModel: AppDIContainer.getBeerDependencies())
                .environmentObject(sheetManager)
        }
    }
}
