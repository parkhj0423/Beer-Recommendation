//
//  UIApplication.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/30.
//

import Foundation
import UIKit

extension UIApplication {
    
    func addTapGestureRecognizer() {
        guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let window = firstScene.windows.first else { return }
        
        let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapGesture.requiresExclusiveTouchType = false
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        window.addGestureRecognizer(tapGesture)
    }
}


extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        // 다른 제스처를 할 때 탭을 감지하고 싶지 않다면 false로 지정
        return true
    }
}
