//
//  ErrorModalViewModifier.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/15.
//

import Foundation
import SwiftUI

protocol GenericError: Error, Identifiable {
    var title: String { get }
    var errorDescription: String { get }
}
