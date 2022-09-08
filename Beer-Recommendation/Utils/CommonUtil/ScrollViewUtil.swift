//
//  ScrollViewUtil.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/09/08.
//

import Foundation
import UIKit

class ScrollViewUtil : NSObject, UIScrollViewDelegate, ObservableObject {
    @Published var isBottomBounceDisable : Bool = false
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.height && isBottomBounceDisable {
            scrollView.contentOffset.y = scrollView.contentSize.height - scrollView.bounds.height
        }
    }
    
}
