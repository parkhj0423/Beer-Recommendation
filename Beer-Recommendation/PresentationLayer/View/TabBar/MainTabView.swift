//
//  MainTabView.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/24.
//

import SwiftUI

struct MainTabView: View {
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
                
                tabBarView()
                
            }
        }
        .ignoresSafeArea(.keyboard)
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
        content()
            .navigationBarTitleDisplayMode(.inline)
            .tag(tag)
    }
    
    private func tabBarView() -> some View {
        VStack {
            Spacer()
            CustomTabBar(selectedTab: $viewRouter.currentTab)
        }
    }
}
