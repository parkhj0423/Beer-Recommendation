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
        .onReceive(viewRouter.$currentPage) { currentPage in
            print(currentPage)
            switch currentPage {
            case .house:
                selectedItem = 0
            case .cart:
                selectedItem = 1
            }
        }
    }
    
    @ViewBuilder
    private func tabBarItem<Content: View>(tag : Int, content: () -> Content) -> some View {
        NavigationView {
            content()
                .toolbar {
                   
                }
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
        }
        .accentColor(.black)
        .tag(tag)
    }
    
    private func tabBarView() -> some View {
        VStack {
            Spacer()
            CustomTabBar(selectedTab: $viewRouter.currentPage)
        }
    }
}
