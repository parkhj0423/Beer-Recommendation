//
//  CustomTabBar.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/21.
//

import SwiftUI

public enum Tab : String, CaseIterable {
    case home
    case favorite
}

struct CustomTabBar: View {
    @Binding var selectedTab : Tab
    private var fillImage : String {
        selectedTab.rawValue + ".fill"
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(.home))
    }
}
