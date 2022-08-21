//
//  CustomModalViewModifier.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/21.
//

import Foundation
import SwiftUI

struct CustomModalViewModifier : ViewModifier {
    @ObservedObject var sheetManager : SheetManager
    
    func body(content: Content) -> some View {
        GeometryReader { geomtry in
            let height = geomtry.size.height
            content
                .overlay(alignment: .bottom) {
                    if sheetManager.sheetType == .bottomSheet {
                        
                        Rectangle()
                            .overlay(CommentView())
                            .cornerRadius(10 , corners: [.topLeft, .topRight])
                            .frame(maxWidth : .infinity, maxHeight: height / 2, alignment: .bottom)
                        
                        
                            .transition(.move(edge: .bottom))
                        
                        
                    } else if sheetManager.sheetType == .miniSheet {
                        Text("miniSheet")
                    }
                }
                .fullScreenCover(isPresented: $sheetManager.isFullScreenSheet, onDismiss: {
                    sheetManager.dismissSheet()
                }) {
                    switch sheetManager.sheetState {
                    default :
                        CommentView()
                    }
                    
                }
                .sheet(isPresented: $sheetManager.isRegularSheet, onDismiss: {
                    sheetManager.dismissSheet()
                }) {
                    switch sheetManager.sheetState {
                    default :
                        CommentView()
                    }
                    
                }
        }
        .ignoresSafeArea()
        
    }
}
