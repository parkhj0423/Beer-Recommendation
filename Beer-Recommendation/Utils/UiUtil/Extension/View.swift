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
    
    func showErrorModal<T: GenericError>(error: Binding<T?>, onDismiss : @escaping () -> ()) -> some View {
        modifier(ErrorModalViewModifier(error: error, onDismiss: onDismiss))
    }
    
    func showSheet(sheetManager : SheetManager) -> some View {
        modifier(CustomSheetViewModifier(sheetManager: sheetManager))
    }
    
    func cornerRadius(_ radius:CGFloat, corners:UIRectCorner)-> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner:Shape {
    
    var radius:CGFloat = .infinity
    var corners:UIRectCorner = .allCorners
    
    func path(in rect:CGRect)->Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii:CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
