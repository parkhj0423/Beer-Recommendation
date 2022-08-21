//
//  CustomModal.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/21.
//

import SwiftUI

struct CustomModal: View {
    
    @ObservedObject var sheetManager : SheetManager
    
    var body: some View {
        VStack(spacing : 0) {
            if sheetManager.sheetType == .bottomSheet {
                Text("bottomSheet")
            } else if sheetManager.sheetType == .miniSheet {
                Text("miniSheet")
            }
        }
//        .fullScreenCover(isPresented: $sheetManager.isFullScreenSheet, onDismiss: {
//            sheetManager.dismissSheet()
//        }) {
//            switch sheetManager.sheetState {
//            default :
//                CommentView()
//            }
//
//        }
//        .sheet(isPresented: $sheetManager.isRegularSheet, onDismiss: {
//            sheetManager.dismissSheet()
//        }) {
//            switch sheetManager.sheetState {
//            default :
//                CommentView()
//            }
//            
//        }
        
        
    }
}
