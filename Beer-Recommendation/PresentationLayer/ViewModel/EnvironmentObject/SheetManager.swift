//
//  SheetManager.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/19.
//

import Foundation
import Combine
import SwiftUI

public enum SheetType : String {
    case bottomSheet
    case fullScreenSheet
    case regularSheet
    case miniSheet
}

public enum SheetState : String,  Identifiable {
    case comment
    case addFavorite
    
    public var id: String { rawValue }
}


final class SheetManager : ObservableObject {
    
    @Published public var sheetType : SheetType? {
        didSet {
            if sheetType == .regularSheet {
                self.isRegularSheet = true
            } else if sheetType == .fullScreenSheet {
                self.isFullScreenSheet = true
            }
        }
    }
    @Published public var sheetState : SheetState?
    
    @Published public var isRegularSheet : Bool = false
    @Published public var isFullScreenSheet : Bool = false
    @Published public var isBottomSheet : Bool = false
    @Published public var isMiniSheet : Bool = false
    
    public func changeSheet(type : SheetType, sheet : SheetState) {
        if self.sheetState != nil {
            self.sheetState = nil
        }
        withAnimation {
            self.sheetType = type
            self.sheetState = sheet
        }
        
    }
    
    public func dismissSheet() {
        self.sheetType = nil
        self.sheetState = nil
        self.isFullScreenSheet = false
        self.isRegularSheet = false
        self.isBottomSheet = false
        self.isMiniSheet = false
        
    }
}
