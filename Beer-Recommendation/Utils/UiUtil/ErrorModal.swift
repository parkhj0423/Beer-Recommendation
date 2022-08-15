//
//  ErrorModal.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/15.
//

import SwiftUI

struct ErrorModal<T : GenericError>: View {
    
    @Binding var error: T?
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            
            RoundedRectangle(cornerRadius: 10, style: .circular)
                .fill(Color.white)
                .overlay(
                    Text(error?.title ?? "")
                )
                .frame(width: width / 5 * 3, height: height / 5)
            
        }
    }
}

