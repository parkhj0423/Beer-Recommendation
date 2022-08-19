//
//  SheetManager.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/19.
//

import Foundation
import Combine

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
    
    @Published private var sheetType : SheetType?
    @Published private var sheetState : SheetState?
    
    public func changeSheet(type : SheetType, sheet : SheetState) {
        if self.sheetState != nil {
            self.sheetState = nil
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.sheetType = type
            self.sheetState = sheet
        }
        
    }
    
    public func dismissSheet() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.sheetState = nil
        }
    }
}
