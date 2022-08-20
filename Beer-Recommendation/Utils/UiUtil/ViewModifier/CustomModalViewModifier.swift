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
        content
            .overlay(alignment: .bottom) {
                if sheetManager.sheetState != nil {
                    CustomModal(sheetManager: sheetManager)
                }
            }
            .ignoresSafeArea()
        
    }
}
