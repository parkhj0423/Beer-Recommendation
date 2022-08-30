//
//  LoadingViewModifier.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/14.
//

import SwiftUI

struct LoadingViewModifier: ViewModifier {
    
    var isLoading: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isLoading)
                .blur(radius: isLoading ? 10 : 0)
            
            if isLoading {
                VStack {
                    ProgressView()
                    Text("Loading...")
                        .font(.caption2)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.secondary.colorInvert().ignoresSafeArea())
                .foregroundColor(Color.primary)
                .opacity(isLoading ? 1 : 0)
                
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}
