//
//  BeerViewModelError.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/15.
//

import Foundation

enum BeerViewModelError : GenericError {
    
    var id: Self { self }
    
    case none
    case unknown
    case internetConnectionError
    case failToLoadData
    case failToAddFavorite
    case failToRemoveFavorite
    case failToUpdateComment
    
    var title: String {
        switch self {
        case .none:
            return ""
        case .unknown:
            return "Unknown"
        case .internetConnectionError:
            return "Fail to connect internet!"
        case .failToLoadData:
            return "Fail to load data!"
        case .failToAddFavorite:
            return "Fail to add favorite!"
        case .failToRemoveFavorite:
            return "Fail to remove favorite!"
        case .failToUpdateComment:
            return "Fail to update comment!"
        
        }
    }
    
    var description: String {
        switch self {
        case .none:
            return ""
        case .unknown:
            return "An Unknown Error has occurred"
        case .internetConnectionError:
            return "Please check the internet connection"
        default :
            return "Please check the logic"
        }
    }
        
    
}
