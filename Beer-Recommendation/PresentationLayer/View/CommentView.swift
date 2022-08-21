//
//  CommentView.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/21.
//

import SwiftUI

struct CommentView: View {
    
    @EnvironmentObject var sheetManager : SheetManager
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Comment View!")
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    dismissButton()
                }
            }
        }
    }
    
    private func dismissButton() -> some View {
        Button {
            sheetManager.dismissSheet()
        } label: {
            Image(systemName: "xmark")
                .resizable()
                .frame(width: 14, height: 14)
                .padding(EdgeInsets(top: 9, leading: 9, bottom: 9, trailing: 9))
        }
    }
    
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView()
    }
}