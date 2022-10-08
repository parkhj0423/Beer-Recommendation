//
//  FavoriteView.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/21.
//

import SwiftUI

struct FavoriteView: View {
    
    @EnvironmentObject var sheetManager : SheetManager
    
    @State private var favoriteList : [BeerEntity] = []
    
    var body: some View {
        VStack {
            ForEach(favoriteList) { favoriteItem in
                Text(favoriteItem.name ?? "")
            }
        }
        .onAppear {
            self.favoriteList = PreferenceUtil().getFavoriteList()
        }
        
    }
    
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
