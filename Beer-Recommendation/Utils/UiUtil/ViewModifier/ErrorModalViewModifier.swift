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
    var description: String { get }
}

struct ErrorModalViewModifier<T : GenericError>: ViewModifier {
    @Binding var error: T?
    var onDismiss : () -> ()
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .overlay(
                    GeometryReader { geometry in
                        let width = geometry.size.width
                        let height = geometry.size.height
                        
                        ZStack {
                            if let error = error {
                                Color.gray.opacity(0.3)
                                
                                RoundedRectangle(cornerRadius: 15, style: .circular)
                                    .fill(Color.white)
                                    .overlay(
                                        VStack(spacing : 0) {
                                            Spacer()
                                            
                                            VStack(spacing : 20) {
                                                Text(error.title)
                                                    .font(.system(size: 20, weight: .bold))
                                                    .font(.system(.headline))
                                                Text(error.description)
                                                    .font(.system(size: 17, weight: .medium))
                                                    .font(.system(.caption))
                                            }
                                            
                                            Spacer()
                                            
                                            Rectangle()
                                                .fill(Color.cyan)
                                                .cornerRadius(15, corners: .bottomLeft)
                                                .cornerRadius(15, corners: .bottomRight)
                                                .frame(maxWidth : width / 5 * 4, maxHeight: 50, alignment: .bottom)
                                                .overlay(
                                                    Text("확인")
                                                        .font(.system(size: 15, weight: .bold))
                                                        .foregroundColor(Color.white)
                                                )
                                                .onTapGesture {
                                                    onDismiss()
                                                }
                                        }
                                    )
                                    .frame(width: width / 5 * 4, height: height / 4)
                            }
                            
                        }
                        
                    }
                        .ignoresSafeArea()
                )
            
        }
    }
}
