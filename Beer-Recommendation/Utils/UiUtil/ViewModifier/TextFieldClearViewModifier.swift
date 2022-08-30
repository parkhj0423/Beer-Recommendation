//
//  TextFieldClearViewModifier.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/30.
//

import Foundation
import SwiftUI

struct TextFieldClearViewModifier: ViewModifier {
    
    @Binding var text: String
    
    public func body(content: Content) -> some View {
        ZStack(alignment: .trailing){
            content
            if !text.isEmpty {
                Button {
                    self.text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color(UIColor.opaqueSeparator))
                        .font(.system(size: 16))
                        .padding(.trailing, 12 )
                }
            }
        }
    }
}
