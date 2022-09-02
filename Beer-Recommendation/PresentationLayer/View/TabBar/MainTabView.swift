//
//  MainTabView.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/24.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var sheetManager : SheetManager
    @ObservedObject var viewRouter : ViewRouter
    
    @State private var selectedItem = 0
    
    init(viewRouter : ViewRouter) {
        self.viewRouter = viewRouter
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack(spacing : 0) {
            ZStack {
                TabView (selection: $selectedItem){
                    tabBarItem(tag: 0) {
                        BeerListView(viewModel: AppDIContainer.getBeerDependencies())
                    }
                    
                    tabBarItem(tag: 1) {
                        CommentView()
                    }
                }
                
                if sheetManager.sheetType != .bottomSheet {
                    tabBarView()
                }                
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .onReceive(viewRouter.$currentTab) { currentPage in
            switch currentPage {
            case .house:
                selectedItem = 0
            case .cart:
                selectedItem = 1
            }
        }
    }
    
    private func tabBarItem<Content: View>(tag : Int, content: () -> Content) -> some View {
        NavigationView {
            content()
                .navigationBarTitleDisplayMode(.inline)
                .tint(.white)
                .navigationTitle("")
                .navigationBarColor(backgroundColor: UIColor.clear, shadowColor: UIColor.clear)
        }
        .tag(tag)
    }
    
    private func tabBarView() -> some View {
        VStack {
            Spacer()
            CustomTabBar(selectedTab: $viewRouter.currentTab)
        }
    }
}
