//
//  FavoriteView.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/21.
//

import SwiftUI

struct FavoriteView: View {
    
    @EnvironmentObject var sheetManager : SheetManager
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(PreferenceUtil.favoriteList ?? []) { favoriteItem in
                    Text(favoriteItem.name ?? "")
                }
            }
        }
    }
    
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
