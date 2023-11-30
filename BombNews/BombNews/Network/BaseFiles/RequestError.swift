//
//  RequestError.swift
//  BombNews
//
//  Created by Barış Şaraldı on 30.11.2023.
//

import Foundation

// MARK: - RequestError
public enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized(code:Int)
    case unexpectedStatusCode(description: String, code: Int)
    case unknown(description: String, code: Int?)
    
    public var customMessage: String {
        switch self {
        case .decode:
            return "Decoding Error"
        case .unauthorized:
            return "Session expired"
        case .noResponse:
            return "Request does not have a response"
        case .invalidURL:
            return "Url is invalid"
        default:
            return "Unknown error"
        }
    }
    
    public var errorCode: Int? {
        switch self {
        case .decode:
            return nil
        case .invalidURL:
            return nil
        case .noResponse:
            return nil
        case .unauthorized(let code):
            return code
        case .unexpectedStatusCode(_, let code):
            return code
        case .unknown(_, let code):
            return code
        }
    }
}
