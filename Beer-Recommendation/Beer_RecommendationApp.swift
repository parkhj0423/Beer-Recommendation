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
    @StateObject var viewRouter = ViewRouter()
    
    
    var body: some Scene {
        WindowGroup {
            MainTabView(viewRouter: viewRouter)
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
                .background(Color(UIColor.systemBackground))
                .environmentObject(sheetManager)
        }
    }
}
