//
//  CustomSheetViewModifier.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/21.
//

import Foundation
import SwiftUI

struct CustomSheetViewModifier : ViewModifier {
    @ObservedObject var sheetManager : SheetManager
    
    func body(content: Content) -> some View {
        GeometryReader { geomtry in
            let height = geomtry.size.height
            
            content
                .overlay(alignment: .bottom) {
                    if sheetManager.sheetType == .bottomSheet {
                        switch sheetManager.sheetState {
                        default :
                            bottomSheetView(content: FavoriteView(viewModel: AppDIContainer.getFavoriteDependencies()), height: height / 3)
                        }
                    }
                }
                .fullScreenCover(isPresented: $sheetManager.isFullScreenSheet, onDismiss: { sheetManager.dismissSheet() }) {
                        switch sheetManager.sheetState {
                        default :
                            FavoriteView(viewModel: AppDIContainer.getFavoriteDependencies())
                        }
                    }
                .sheet(isPresented: $sheetManager.isRegularSheet, onDismiss: { sheetManager.dismissSheet() }) {
                        switch sheetManager.sheetState {
                        default :
                            FavoriteView(viewModel: AppDIContainer.getFavoriteDependencies())
                        }
                    }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    private func bottomSheetView<Content : View>(content : Content, height : CGFloat) -> some View {
        Rectangle()
            .overlay(content)
            .cornerRadius(10 , corners: [.topLeft, .topRight])
            .frame(maxWidth : .infinity, maxHeight: height, alignment: .bottom)
            .transition(.move(edge: .bottom))
            .background(Rectangle()
                .cornerRadius(10 , corners: [.topLeft, .topRight])
                .shadow(color: .black.opacity(0.3), radius: 7, y: -2)
            )
    }
    
}
