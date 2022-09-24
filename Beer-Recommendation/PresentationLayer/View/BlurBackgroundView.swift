//
//  BlurBackgroundView.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/09/24.
//

import Foundation
import SwiftUI

struct BlurBackgroundView :UIViewRepresentable {
    
    func makeUIView(context : Context) -> UIVisualEffectView{
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemThickMaterialDark))
        return view
    }
    
    func updateUIView(_ uiView : UIVisualEffectView, context : Context) {
        
    }
}
