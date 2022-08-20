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
    
    @Published public var sheetType : SheetType? {
        didSet {
            if sheetType == .regularSheet {
                self.isRegularSheet = true
            }
        }
    }
    @Published public var sheetState : SheetState?
    
    @Published public var isRegularSheet : Bool = false
    
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
            self.sheetType = nil
            self.sheetState = nil
        }
    }
}
