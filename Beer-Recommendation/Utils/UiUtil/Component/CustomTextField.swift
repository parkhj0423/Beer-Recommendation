//
//  CustomTextField.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/30.
//

import SwiftUI

struct CustomTextField: View {
    
    let backgroundColor: Color = Color("ColorTextField")
    
    @Binding var text: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            Image(systemName: "magnifyingglass")
                .padding(.leading, 10)
                .zIndex(2)
            
            TextField("Search Your Beer!", text: $text)
                .padding(EdgeInsets(top: 10, leading: 35, bottom: 10, trailing: 7))
                .font(.system(size: 15))
                .background(RoundedRectangle(cornerRadius: 10).fill(backgroundColor))
                .clearText(text: $text)
                
        }
        .padding([.leading, .trailing], 10)
    }
}
