//
//  ViewRouter.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/23.
//

import Foundation
import Combine

public enum Tab : String, CaseIterable {
    case house
    case cart
}

class ViewRouter: ObservableObject {
    
    @Published public var currentTab: Tab = .house
    
    public func changeCurrentPage(_ to : Tab) {
        self.currentTab = to
    }
}

