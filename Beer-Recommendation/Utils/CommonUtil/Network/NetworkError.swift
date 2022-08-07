//
//  NetworkError.swift
//  Beer-Recommendation
//
//  Created by Catius_Macbook_Air on 2022/08/07.
//

import Foundation

enum NetworkError: Error {
    case decodingError
    case invalidURLError
    case noResponseError
    case serverError
    case badRequestError
    case internetConnectionError
    case unknownError

    var errorMessage: String {
        switch self {
        case .decodingError :
            return "Decoding error"
        case .invalidURLError :
            return "Invalid URL"
        case .noResponseError :
            return "No Response"
        case .serverError :
            return "Server Error"
        case .badRequestError :
            return "Bad Request From Client"
        case .internetConnectionError :
            return "Internet Connection is unstable"
        default:
            return "Unknown error"
        }
    }
}
