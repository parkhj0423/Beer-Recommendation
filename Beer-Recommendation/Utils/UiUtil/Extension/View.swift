//
//  View.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/14.
//

import Foundation
import SwiftUI

extension View {
    func showLoadingView(isLoading: Bool) -> some View {
        modifier(LoadingViewModifier(isLoading: isLoading))
    }
}
