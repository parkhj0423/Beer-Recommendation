//
//  BeerDetailView.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/09/01.
//

import SwiftUI

struct BeerDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel : BeerViewModel
    var item : BeerEntity
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("go back")
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

